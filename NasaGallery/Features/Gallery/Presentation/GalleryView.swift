//
//  GalleryView.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI

struct GalleryView: View {
    @StateObject var viewModel: ViewModel
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: ViewModel(container: viewModel.container))
    }
    var body: some View {
        VStack(spacing: 0) {
            switch (viewModel.galleryImages) {
            case .notRequested:
                Color.clear
                    .onAppear {
                        viewModel.loadClass()
                    }
            case .isLoading:
                Spacer()
                ProgressView()
                Spacer()
            case .failed(_):
                Text("Error")
            case .loaded(let images):
                ForEach(images) { val in
                    AsyncImage(url: URL(string: val.url))
                        .frame(width: 200, height: 200)
                }
            }
        }
        .padding([.trailing, .leading], 20)
        .padding(.top, 5)
        .background(Color.white)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea()
    }
}
