//
//  NetworkMonitorService.swift
//  CVSChallenge
//
//  Created by Daniel Mori on 02/09/24.
//

import Foundation
import Network

@Observable
class NetworkMonitorService {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
