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
            getPlacesFromFourSquare()
        } else {
            getPlacesFromCoreDate()
        }
    }
    
    // MARK: Private Methods

    private func getPlacesFromFourSquare() {
        
    }
    
    private func getPlacesFromCoreDate() {
        let request = NSFetchRequest<PlaceEntity>(entityName: entityName)
        
        do {
            fivePlaces = try self.container.viewContext.fetch(request)
        } catch let error {
            print("Error executing fetch request \(error)")
        }
    }
    
    private func addPlaces() {
        for place in fivePlaces {
            let placeEntity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: container.viewContext)
            placeEntity.setValue(place.name, forKey: "name")
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
