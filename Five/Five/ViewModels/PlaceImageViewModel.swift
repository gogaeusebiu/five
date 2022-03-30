//
//  PlaceImageViewModel.swift
//  Five
//
//  Created by Goga Eusebiu on 30.03.2022.
//

import Foundation
import Combine
import UIKit
import SwiftUI

final class PlaceImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    @Published var placeImageRepository = PlaceImageRepository()
    
    private var placeFsqId = ""
    private var cancellables: Set<AnyCancellable> = []

    init(_ placeFsqId: String?) {
        self.placeFsqId = placeFsqId ?? ""
        getAllImages()
    }
    
    private func getAllImages() {
        self.isLoading = true
        if (self.placeFsqId != "") {
            placeImageRepository.getAllImages(self.placeFsqId).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Finished successfuly")
                    }
                },
                receiveValue: { images in
                    if images.isEmpty {
                        self.isLoading = false
                    } else {
                        self.getImage(images.first!)
                    }
                }
            ).store(in: &cancellables)

        }
    }
    
    private func getImage(_ imageModel: PlaceImageDto) {
        placeImageRepository.dowloadImage(with: imageModel).sink(
            receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    print("Finished successfuly")
                }
            },
            receiveValue: { imageData in
                self.isLoading = false
                self.image = imageData
            }
        ).store(in: &cancellables)
    }
}
