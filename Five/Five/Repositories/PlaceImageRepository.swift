//
//  PlaceImageRepository.swift
//  Five
//
//  Created by Goga Eusebiu on 30.03.2022.
//

import Foundation
import Combine
import SwiftUI

final class PlaceImageRepository: ObservableObject {
    private let urlSession: URLSession
    private let cache: NSCache<NSURL, UIImage>

    init(urlSession: URLSession = .shared,
         cache: NSCache<NSURL, UIImage> = .init()) {
        self.urlSession = urlSession
        self.cache = cache
    }
    
    func getAllImages(_ placeFsqId: String) -> AnyPublisher<[PlaceImageDto], Never> {
        var urlComponents = URLComponents(string: UrlPaths.baseUrl + placeFsqId + "/" + UrlPaths.placeImageUrl)
        
        var queryItems = [URLQueryItem]()
        for (key, value) in UrlPaths.imagePlaceRequestParameters() {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        for (key, value) in UrlPaths.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ $0.data })
            .decode(type: [PlaceImageDto].self, decoder: JSONDecoder())
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func dowloadImage(with imageModel: PlaceImageDto) -> AnyPublisher<UIImage, Error> {
        
        let url = URL(string: imageModel.prefix + UrlPaths.imageSizeUrl + imageModel.suffix)
        
        if let image = cache.object(forKey: (url!) as NSURL) {
            return Just(image)
                .setFailureType(to: Error.self)
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        } else {
            return urlSession
                .dataTaskPublisher(for: url!)
                .map(\.data)
                .tryMap { data in
                    guard let image = UIImage(data: data) else {
                        throw URLError(.badServerResponse, userInfo: [
                            NSURLErrorFailingURLErrorKey: url!
                        ])
                    }
                    return image
                }
                .receive(on: DispatchQueue.main)
                .handleEvents(receiveOutput: { [cache] image in
                    cache.setObject(image, forKey: url! as NSURL)
                })
                .eraseToAnyPublisher()
        }
    }
}
