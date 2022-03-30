//
//  ManagedObject.swift
//  Five
//
//  Created by Goga Eusebiu on 29.03.2022.
//

import CoreData

struct PlacesDto: Codable {
    var results: [PlaceDto]
}

struct PlaceDto: Codable {
    var fsq_id: String
    var categories: [CategoriesDto]
    var chains: [ChainsDto]
    var distance: Int64
    var name: String
    var location: LocationDto
    var geocodes: GeoCodeDto
    var related_places: RelatedPlacesDto
    var timezone: String
}

struct LocationDto: Codable {
    var address: String
    var country: String
    var locality: String
    var region: String
    var cross_street: String
    var formatted_address: String
    var postcode: String
}

struct CategoriesDto: Codable {
    var id: Int
    var name: String
    var icon: IconDto
}

struct IconDto: Codable {
    var prefix: String
    var suffix: String
}

struct ChainsDto: Codable {
}
struct RelatedPlacesDto: Codable {
}

struct GeoCodeDto: Codable {
    var main: MainDto
}

struct MainDto: Codable {
    var latitude: Double
    var longitude: Double
}
