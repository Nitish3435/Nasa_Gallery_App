//
//  GalleryImageDetailView.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 19/02/23.
//

import SwiftUI

struct GalleryImageDetailView: View {
    @Environment(\.presentationMode) var present
    @Binding var images: [ImageModel]
    @Binding var index: Int
    var body: some View {
        VStack(spacing: 20) {
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images.sorted(by: { (lhs, rhs) in
                    lhs.date > rhs.date
                }), id: \.self) { imageName in
                    AsyncImage(
                        url: URL(string: imageName.url),
                        content: { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(2)
                        },
                        placeholder: {
                            Image("Placeholder")
                                .resizable()
                                .scaledToFill()
                                .cornerRadius(2)
                        }
                    )
                }
            }
            .aspectRatio(4/3, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images.sorted(by: { (lhs, rhs) in
                    lhs.date > rhs.date
                }), id: \.self) { imageName in
                    Text(imageName.explanation)
                        .font(.system(size: 9))
                        .foregroundColor(.white)
                }
            }
            .aspectRatio(3/4, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: 15))
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

