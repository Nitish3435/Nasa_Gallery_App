//
//  GalleryView.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI

struct GalleryView: View {
    @State var test: Bool = false
    let threeColumnGrid = [GridItem(.flexible(minimum: 40)),
                           GridItem(.flexible(minimum: 40)),
                           GridItem(.flexible(minimum: 40))]
    @StateObject var viewModel: ViewModel
    init(viewModel: ViewModel) {
        _viewModel = StateObject(wrappedValue: ViewModel(container: viewModel.container))
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("NASA Gallery")
                .font(Font.system(size: 46, weight: .bold))
                .foregroundLinearGradient(
                    colors: [.red, .blue, .green, .yellow, .cyan],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(y: test ? 0 : -80)
                .animation(.interpolatingSpring(stiffness: 100,
                                                damping: 5, initialVelocity: 5), value: test)
                .padding(.bottom, 15)
            HStack(spacing: 0) {
                Spacer()
                VStack {
                    switch (viewModel.galleryImages) {
                    case .notRequested:
                        Color.clear
                            .onAppear {
                                test.toggle()
                                viewModel.loadClass()
                            }
                    case .isLoading:
                        Spacer()
                        LoadingFiveLinesCenter(color: .black)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    case .failed(_):
                        Text("Error")
                    case .loaded(let images):
                        ScrollView(showsIndicators: false) {
                            LazyVGrid(columns: threeColumnGrid, alignment: .leading, spacing: 36) {
                                ForEach(images.sorted(by: { (lhs, rhs) in
                                    lhs.date > rhs.date
                                })) { image in
                                    GeometryReader { reader in
                                        VStack(spacing: 0) {
                                            AsyncImage(
                                                url: URL(string: image.url),
                                                content: { image in
                                                    image
                                                        .resizable()
                                                        .frame(width: reader.size.width)
                                                        .cornerRadius(2)
                                                },
                                                placeholder: {
                                                    Image("Placeholder")
                                                        .resizable()
                                                        .frame(width: reader.size.width)
                                                        .cornerRadius(2)
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
        .padding([.trailing, .leading], 20)
        .padding(.top, 5)
        .background(Color.black)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}
