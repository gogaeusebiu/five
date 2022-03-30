//
//  UrlPaths.swift
//  Five
//
//  Created by Goga Eusebiu on 29.03.2022.
//

struct UrlPaths {
    static let nearPlacesUrl = "https://api.foursquare.com/v3/places/nearby"
    
    static func requestParameters(_ latitude: Double, _ longitude: Double) -> [String: String] {
        return [
            "limit": "5",
            "ll": "\(latitude),\(longitude)",
            "client_id": "JG1BXGTRHEKTZET5T302XDXCMURJ2F53X2VSEVTZ0YBYB42B",
            "client_secret": "VT0MCKXP13AL34H4ZIW0KNW4GEDTYKER1XZRFSFO5BCG0EZR"]
    }
    
    static let headers = ["Accept": "application/json",
                          "Authorization": "fsq3fPiOCnR7ZjdNIA1QF95sfKN9isl1NGiUTX0ATOG2pxQ="]
}
