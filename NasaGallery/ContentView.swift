//
//  ContentView.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    var body: some View {
        GalleryView(viewModel: GalleryView.ViewModel(container: viewModel.container))
    }
}
// MARK: - ViewModel

extension ContentView {
    class ViewModel: ObservableObject {
        let container: DIContainer
        init(container: DIContainer) {
            self.container = container
        }
    }
}
