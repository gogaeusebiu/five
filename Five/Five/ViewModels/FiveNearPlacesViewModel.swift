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
    @Published var fiveNearPlacesCoreDataRepository = FiveNearPlacesCoreDataRepository()
    @Published var fiveNearPlacesRepository = FiveNearPlacesRepository()
    @Published var fivePlaces: [PlaceEntity] = []
    
    private var cancellables: Set<AnyCancellable> = []

    init() {
        fiveNearPlacesCoreDataRepository.$fivePlaces.assign(to: \.fivePlaces, on: self)
            .store(in: &cancellables)
    }
    
    func getPlaces(for location: CLLocation) {
        if NetworkMonitor.shared.status == .satisfied {
            fiveNearPlacesRepository.getPlaces(for: location).sink(
                receiveCompletion: { completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                    case .finished:
                        print("Finished successfuly")
                    }
                },
                receiveValue: { places in
                    if places.results.isEmpty {
                        let items = Bundle.main.decode(type: PlacesDto.self, from: "PlacesMock.json")
                        self.fiveNearPlacesCoreDataRepository.addPlacesToDataBase(items)
                    } else {
                        self.fiveNearPlacesCoreDataRepository.addPlacesToDataBase(places)
                    }
                }
            ).store(in: &cancellables)
        } else {
            fiveNearPlacesCoreDataRepository.getPlacesFromCoreDate()
        }
    }
}
