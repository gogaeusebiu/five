//
//  FiveNearPlacesView.swift
//  Five
//
//  Created by Goga Eusebiu on 25.03.2022.
//

import SwiftUI

struct FiveNearPlacesView: View {
    @ObservedObject var fiveNearPlacesViewModel: FiveNearPlacesViewModel
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack{
            
        }.onAppear {
            locationManager.checkIfUserLocationIsEnabled()
            fiveNearPlacesViewModel.getPlaces(for: locationManager.userLocation)
        }
    }

}
