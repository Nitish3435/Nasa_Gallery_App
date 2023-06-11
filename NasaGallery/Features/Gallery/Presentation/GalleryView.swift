//
//  GalleryView.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI
import CachedAsyncImage

struct GalleryView: View {
    @State var animateText: Bool = false
    @State var isActive: Bool = false
    @State var index: Int = 0
    let threeColumnGrid = [GridItem(.flexible(minimum: 40)),
                           GridItem(.flexible(minimum: 40)),
                           GridItem(.flexible(minimum: 40))]
    @StateObject var network = NetworkConnection()
    @StateObject var viewModel: ViewModel
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: ViewModel(container: viewModel.container))
    }
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    Text("Hello BATCH 2")
                        .font(Font.custom("WorkSans-Regular", size: 30))
                        .foregroundLinearGradient(
                            colors: [.white],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                        .offset(y: animateText ? 0 : -80)
                        .animation(.interpolatingSpring(stiffness: 100,
                                                        damping: 5, initialVelocity: 5),
                                   value: animateText)
                        .padding(.bottom, 15)
                    Spacer()
                }
                HStack(spacing: 0) {
                    Spacer()
                    VStack {
                        switch (viewModel.galleryImages) {
                        case .notRequested:
                            Color.clear
                                .onAppear {
                                    animateText.toggle()
                                    viewModel.loadClass()
                                }
                        case .isLoading:
                            Spacer()
                            LoadingFiveLinesCenter(color: .green)
                                .frame(maxWidth: .infinity, alignment: .center)
                            Spacer()
                        case .failed(let error):
                            HStack {
                                Spacer()
                                VStack {
                                     Text("Something went wrong")
                                         .font(.headline)
                                         .padding()
                                    Text("\(error.localizedDescription)")
                                         .foregroundColor(.red)
                                         .padding()
                                    Button(action: viewModel.loadClass) {
                                         Text("Try again")
                                             .foregroundColor(.white)
                                             .padding(.horizontal, 20)
                                             .padding(.vertical, 10)
                                             .background(Color.blue)
                                             .cornerRadius(10)
                                     }
                                 }
                                Spacer()
                            }
                        case .loaded(let images):
                            ScrollView(showsIndicators: false) {
                                LazyVGrid(columns: threeColumnGrid, alignment: .leading, spacing: 25) {
                                    ForEach(images.sorted(by: { (lhs, rhs) in
                                        lhs.date > rhs.date
                                    })) { nasaImage in
                                        GeometryReader { reader in
                                            VStack(spacing: 0) {
                                                CachedAsyncImage(
                                                    url: URL(string: nasaImage.url),
                                                    content: { image in
                                                        image
                                                            .resizable()
                                                            .frame(width: reader.size.width)
                                                            .cornerRadius(2)
                                                            .onTapGesture {
                                                                index = images.sorted(by: {
                                                                    (lhs, rhs) in
                                                                    lhs.date > rhs.date

                                                                }).firstIndex(of: nasaImage) ?? 0
                                                                isActive.toggle()
                                                            }
                                                    },
                                                    placeholder: {
                                                        Image("Placeholder")
                                                            .resizable()
                                                            .frame(width: reader.size.width)
                                                            .cornerRadius(2)
                                                            .onTapGesture {
                                                                index = images.sorted(by: {
                                                                    (lhs, rhs) in
                                                                    lhs.date > rhs.date

                                                                }).firstIndex(of: nasaImage) ?? 0
                                                                isActive.toggle()
                                                            }
                                                    }
                                                )
                                            }
                                        }
                                        .clipped()
                                        .aspectRatio(1, contentMode: .fit)
                                        .padding(.bottom, 10)
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                }
                Spacer()
            }
            .onAppear {
                network.checkConnection()
            }
            .navigationDestination(isPresented: $isActive) {
                GalleryImageDetailView(
                   images: $viewModel.loadedImages,
                   index: $index)
            }
            .padding([.trailing, .leading], 20)
            .padding(.top, 5)
            .background(Color.black)
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
            .ignoresSafeArea(.keyboard, edges: .bottom)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
