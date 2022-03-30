//
//  MapPlaceDtoToPlaceEntity.swift
//  Five
//
//  Created by Goga Eusebiu on 29.03.2022.
//

import Foundation

struct Mapper {
    static func mapPlaceDtoToPlaceEntity(_ placeDto: PlaceDto) -> PlaceEntity {
        let placeEntity = PlaceEntity()
        
        placeEntity.name =          placeDto.name
        placeEntity.distance =      placeDto.distance
        placeEntity.country =       placeDto.location.country
        placeEntity.streetAddress = placeDto.location.address
        placeEntity.locality =      placeDto.location.locality
        placeEntity.region =        placeDto.location.region
        
        return placeEntity
    }
}
