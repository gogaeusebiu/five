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
    @State var alertVisible = false
    
    var body: some View {
        VStack{
            List {
                ForEach(fiveNearPlacesViewModel.fivePlaces) { place in
                    PlaceCellView(place: place)
                        .cornerRadius(5)
                        .shadow(radius: 5)
                }
            }
            .listStyle(GroupedListStyle())
            .onAppear(perform: {
                UITableView.appearance().contentInset.top = -35
            })
        }
        .alert(isPresented: $alertVisible) {
            Alert (title: Text("Location is not enabled"),
                   message: Text("Go to Settings?"),
                   primaryButton: .default(Text("Settings"), action: {
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
            }),
                   secondaryButton: .default(Text("Cancel")))
        }
        .onAppear {
            fiveNearPlacesViewModel.getPlaces(for: locationManager.userLocation)
        }
    }
    
}
