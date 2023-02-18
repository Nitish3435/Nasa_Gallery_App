//
//  NasaGalleryApp.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI

@main
struct NasaGalleryApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentView.ViewModel(container: .defaultValue))
        }
    }
}
