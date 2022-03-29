//
//  FiveNearPlacesViewModel.swift
//  Five
//
//  Created by Goga Eusebiu on 25.03.2022.
//

import Combine
import Foundation
import CoreLocation

final class FiveNearPlacesViewModel: ObservableObject {
    
    @Published var fiveNearPlacesRepository = FiveNearPlacesRepository()
    @Published var fivePlaces: [PlaceEntity] = []
    
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fiveNearPlacesRepository.$fivePlaces.assign(to: \.fivePlaces, on: self)
            .store(in: &cancellables)
    }
    
    func getPlaces(for location: CLLocation) {
        fiveNearPlacesRepository.getPlaces(for: location)
    }
}
