//
//  NasaGalleryApp.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI

@main
struct NasaGalleryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
