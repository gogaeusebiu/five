//
//  FiveNearPlacesCoreDataRepository.swift
//  Five
//
//  Created by Goga Eusebiu on 30.03.2022.
//

import Foundation
import CoreData

final class FiveNearPlacesCoreDataRepository: ObservableObject {
    @Published var fivePlaces: [PlaceEntity] = []
    
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
    
    func getPlacesFromCoreDate() {
        let request = NSFetchRequest<PlaceEntity>(entityName: entityName)
        
        do {
            fivePlaces = try self.container.viewContext.fetch(request)
        } catch let error {
            print("Error executing fetch request \(error)")
        }
    }
    
    func addPlacesToDataBase(_ placesDto: PlacesDto) {
        removePlaces()
        for place in placesDto.results {
            let placeEntity = PlaceEntity(context: container.viewContext)
            
            placeEntity.fsqId = place.fsq_id
            placeEntity.name = place.name
            placeEntity.distance = place.distance
            placeEntity.region = place.location.region
            placeEntity.locality = place.location.locality
            placeEntity.streetAddress = place.location.address
            placeEntity.country = place.location.country
            
            self.fivePlaces.append(placeEntity)
        }
        
        save()
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
}
