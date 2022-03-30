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
        ZStack(alignment: .bottom) {
            PlaceImageView(place.fsqId)
            Spacer()
            
            ZStack() {
                VStack() {
                    HStack {
                        Text("distance \(place.distance) meters")
                            .font(.system(size: 12).bold()).padding(.all)
                            .foregroundColor(Color.white)

                        Spacer()
                        Text(place.streetAddress ?? "")
                            .font(.system(size: 12).bold()).padding(.all)
                            .foregroundColor(Color.white)
                    }
                    
                    Text(place.name ?? "")
                        .font(.system(size: 18).bold()).padding(.all)
                        .foregroundColor(Color.white)

                    Text(place.locality ?? "")
                        .font(.system(size: 18).bold()).padding(.all)
                        .foregroundColor(Color.white)
                    
                    HStack {
                        Text(place.region ?? "")
                            .font(.system(size: 12).bold()).padding(.all)
                            .foregroundColor(Color.white)

                        Spacer()
                        Text(place.country ?? "")
                            .font(.system(size: 12).bold()).padding(.all)
                            .foregroundColor(Color.white)
                    }
                }
                .background(Color.clear)
            }
            .background(Color.black.opacity(0.4))
            .frame(height: 200)
        }
    }
}
