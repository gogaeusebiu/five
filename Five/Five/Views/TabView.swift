//
//  ContentView.swift
//  Five
//
//  Created by Goga Eusebiu on 25.03.2022.
//

import SwiftUI

struct TabView: View {
    @State private var selectedScreen = 1

    var body: some View {
        VStack {
            Picker(selection: $selectedScreen, label: Text("Picker"), content: {
                Text("5 Near Places").tag(1)
                Text("About us").tag(2)
            })
                .pickerStyle(SegmentedPickerStyle())
                .padding()
        }
        Spacer()
        if selectedScreen == 1 {
            FiveNearPlacesView(fiveNearPlacesViewModel: FiveNearPlacesViewModel())
        } else {
            AboutUs()
        }
        Spacer()
    }
}

