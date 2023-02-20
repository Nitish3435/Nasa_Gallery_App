//
//  ActivityIndicator.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import SwiftUI

struct ActivityIndicatorView: UIViewRepresentable {
    var style: UIActivityIndicatorView.Style = .medium
    private let spinner: UIActivityIndicatorView = {
        $0.hidesWhenStopped = true
        return $0
    }(UIActivityIndicatorView(style: .medium))

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorView>) -> UIActivityIndicatorView {
        spinner.style = style
        return spinner
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorView>) {
        spinner.startAnimating()
    }
}
struct LoadingFiveLinesCenter: View {

    @State var isAnimating: Bool = false
    let timing: Double

    let maxCounter: Int = 5

    let frame: CGSize
    let primaryColor: Color

    init(color: Color = .black, size: CGFloat = 50, speed: Double = 0.5) {
        timing = speed
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }

    var body: some View {
        HStack(spacing: frame.width / 10) {
            ForEach(0..<5) { index in
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(primaryColor)
                    .frame(maxHeight: isAnimating ? frame.height / 3 : .infinity)
                    .animation(
                        Animation
                            .easeInOut(duration: timing)
                            .repeatForever(autoreverses: true)
                            .delay(
                                index == 2 ? 0.0 :
                                    (index == 1 || index == 3) ? timing / 3 :
                                    timing / 3 * 2
                            ), value: isAnimating
                    )
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .center)
        .onAppear {
            isAnimating.toggle()
        }
    }
}
