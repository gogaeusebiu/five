//
//  PlaceCellView.swift
//  Five
//
//  Created by Goga Eusebiu on 29.03.2022.
//

import SwiftUI

struct PlaceCellView: View {
    var place: PlaceEntity
    
    var body: some View {
        VStack() {
            HStack {
                Text("distance \(place.distance) meters").font(.system(size: 12)).padding(.all)
                Spacer()
                Text(place.streetAddress ?? "").font(.system(size: 12).bold()).padding(.all)
            }
            
            Text(place.name ?? "").font(.largeTitle).padding(.all)
            Text(place.locality ?? "").font(.largeTitle).padding(.all)
            
            HStack {
                Text(place.region ?? "").font(.system(size: 12).bold()).padding(.all)
                Spacer()
                Text(place.country ?? "").font(.system(size: 12).bold()).padding(.all)
            }
        }.background(Color(.systemGray5))
    }
}
