//
//  GalleryImageDetailView.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 19/02/23.
//

import SwiftUI
import CachedAsyncImage
import SimpleToast

struct GalleryImageDetailView: View {
    let selectToastOptions = SimpleToastOptions(alignment: .top, hideAfter: 3,
                                                animation: .easeInOut, modifierType: .scale)
    @State var showSelectToast: Bool = false
    @Environment(\.presentationMode) var present
    @Binding var images: [ImageModel]
    @Binding var index: Int
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button(action: {
                    present.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                })
                Spacer()
            }
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images.sorted(by: { (lhs, rhs) in
                    lhs.date > rhs.date
                }), id: \.self) { imageName in
                    CachedAsyncImage(
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
            ScrollView(showsIndicators: false) {
                Text(images[index].title)
                    .font(Font.custom("WorkSans-Regular", size: 25))
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                Text(images[index].explanation)
                    .font(Font.custom("WorkSans-Regular", size: 15))
                    .foregroundColor(.white)
            }
            Spacer()
            HStack {
                Image(systemName: "c.circle")
                    .foregroundColor(.red)
                    .font(.system(size: 20))
                Text(images[index].copyRight ?? "CopyrightNASA")
                    .font(Font.custom("WorkSans-Regular", size: 20))
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
            Spacer()
        }
        .onAppear {
            showSelectToast.toggle()
        }
        .padding([.trailing, .leading], 20)
        .padding(.top, 5)
        .background(Color.black)
        .simpleToast(isPresented: $showSelectToast, options: selectToastOptions) {
            VStack(alignment: .leading) {
                HStack {
                    Text("<< Swipe left or Swipe right >>")
                        .font(.custom("WorkSans-Regular", size: 16))
                        .padding()
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
                .background(Color.green)
                .cornerRadius(8)
                .foregroundColor(Color.white)
            }
            .padding([.trailing, .leading], 36)
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .frame(maxHeight: .infinity)
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

