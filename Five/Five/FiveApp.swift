//
//  FiveApp.swift
//  Five
//
//  Created by Goga Eusebiu on 25.03.2022.
//

import SwiftUI

@main
struct FiveApp: App {
    @StateObject private var locationManager = LocationManager()
    
    init() {
        NetworkMonitor.shared.startMonitoring()
    }
    
    var body: some Scene {
        WindowGroup {
            TabView()
                .onAppear {
                    locationManager.checkIfUserLocationIsEnabled()
                }
                .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}
