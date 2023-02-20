//
//  Network.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 19/02/23.
//

import Foundation
import Network

class NetworkConnection: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")
    @Published private(set) var connected: Bool = false
    @Published var showToast: Bool = false

    func checkConnection() {
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                DispatchQueue.main.async {
                    self.connected = true
                    self.showToast = false
                }
            } else {
                DispatchQueue.main.async {
                    self.connected = false
                    self.showToast = true
                }
            }
        }
        monitor.start(queue: queue)
    }
}

