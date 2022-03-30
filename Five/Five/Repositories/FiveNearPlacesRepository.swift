//
//  FiveNearPlacesRepository.swift
//  Five
//
//  Created by Goga Eusebiu on 25.03.2022.
//

import Combine
import Foundation
import CoreLocation

final class FiveNearPlacesRepository: ObservableObject {
    
    func getPlaces(for location: CLLocation) -> AnyPublisher<PlacesDto, Never> {
        var urlComponents = URLComponents(string: UrlPaths.baseUrl + UrlPaths.nearPlacesUrl)
        
        var queryItems = [URLQueryItem]()
        for (key, value) in UrlPaths.nearPlaceRequestParameters(location.coordinate.latitude, location.coordinate.longitude) {
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
            .decode(type: PlacesDto.self, decoder: JSONDecoder())
            .replaceError(with: PlacesDto(results: []))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
