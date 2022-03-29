//
//  CheckInternetConnection.swift
//  Five
//
//  Created by Goga Eusebiu on 28.03.2022.
//

import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    let monitor = NWPathMonitor()
    var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
}
