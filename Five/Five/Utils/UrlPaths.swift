//
//  UrlPaths.swift
//  Five
//
//  Created by Goga Eusebiu on 29.03.2022.
//

struct UrlPaths {
    static let baseUrl = "https://api.foursquare.com/v3/places/"
    static let nearPlacesUrl = "nearby"
    static let placeImageUrl = "photos"
    static let imageSizeUrl = "original"
    
    static func nearPlaceRequestParameters(_ latitude: Double, _ longitude: Double) -> [String: String] {
        return [
            "limit": "5",
            "ll": "\(latitude),\(longitude)",
            "client_id": "JG1BXGTRHEKTZET5T302XDXCMURJ2F53X2VSEVTZ0YBYB42B",
            "client_secret": "VT0MCKXP13AL34H4ZIW0KNW4GEDTYKER1XZRFSFO5BCG0EZR"]
    }
    
    static func imagePlaceRequestParameters() -> [String: String] {
        return [
            "limit": "1"
        ]
    }
    
    
    static let headers = ["Accept": "application/json",
                          "Authorization": "fsq3fPiOCnR7ZjdNIA1QF95sfKN9isl1NGiUTX0ATOG2pxQ="]
}
