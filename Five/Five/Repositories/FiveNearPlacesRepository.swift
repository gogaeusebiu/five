//
//  FiveNearPlacesRepository.swift
//  Five
//
//  Created by Goga Eusebiu on 25.03.2022.
//

import Combine
import CoreData
import Foundation
import CoreLocation
import SwiftUI

final class FiveNearPlacesRepository: ObservableObject {
    @Published var fivePlaces: [PlaceEntity] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let container: NSPersistentContainer
    private let containerName = "PlacesContainer"
    private let entityName = "PlaceEntity"
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading core data \(error)")
            }
        }
    }
    
    func getPlaces(for location: CLLocation) {
        if NetworkMonitor.shared.status == .satisfied {
            getPlacesFromFourSquare(for: location).sink(
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
                        self.addPlacesToDataBase(items)
                    } else {
                        self.addPlacesToDataBase(places)
                    }
                }
            ).store(in: &cancellables)
        } else {
            getPlacesFromCoreDate()
        }
    }
    
    // MARK: Private Methods
    
    private func getPlacesFromFourSquare(for location: CLLocation) -> AnyPublisher<PlacesDto, Never> {
        var urlComponents = URLComponents(string: UrlPaths.nearPlacesUrl)
        
        var queryItems = [URLQueryItem]()
        for (key, value) in UrlPaths.requestParameters(location.coordinate.latitude, location.coordinate.longitude) {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        urlComponents?.queryItems = queryItems
        
        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"
        
        for (key, value) in UrlPaths.headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({ data, response in
                return data
            })
            .decode(type: PlacesDto.self, decoder: JSONDecoder())
            .replaceError(with: PlacesDto(results: []))
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    private func getPlacesFromCoreDate() {
        let request = NSFetchRequest<PlaceEntity>(entityName: entityName)
        
        do {
            fivePlaces = try self.container.viewContext.fetch(request)
        } catch let error {
            print("Error executing fetch request \(error)")
        }
    }
    
    private func addPlacesToDataBase(_ placesDto: PlacesDto) {
        for place in placesDto.results {
            let placeEntity = PlaceEntity(context: container.viewContext)
            
            placeEntity.name = place.name
            placeEntity.distance = place.distance
            placeEntity.region = place.location.region
            placeEntity.locality = place.location.locality
            placeEntity.streetAddress = place.location.address
            placeEntity.country = place.location.country
            
            self.fivePlaces.append(placeEntity)
        }
        
        applyChanges()
    }
    
    private func removePlaces() {
        // Create Fetch Request
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        // Create Batch Delete Request
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try container.viewContext.execute(batchDeleteRequest)
        } catch {
            print("Error delete from Core Data \(error)")
        }
    }
    
    private func save() {
        do {
            try self.container.viewContext.save()
        } catch let error {
            print("Error saving to Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        save()
    }
}
