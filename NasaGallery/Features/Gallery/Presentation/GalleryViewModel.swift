//
//  GalleryViewModel.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation

extension GalleryView {
    class ViewModel: ObservableObject {
        @Published var galleryImages: Loadable<[ImageModel]>
        @Published var loadedImages: [ImageModel] = []
        let container: DIContainer
        init(container: DIContainer, galleryImages: Loadable<[ImageModel]> = .notRequested) {
            self.container = container
            self.galleryImages = galleryImages
        }
        func loadClass() {
            let cancelBag = CancelBag()
            self.galleryImages = .isLoading(last: nil, cancelBag: cancelBag)
            container.useCases.galleryUseCase
                .getGalleryImagesUseCase.execute(data: "") { result in
                    switch result {
                    case .success(let images):
                        DispatchQueue.main.async {
                            self.galleryImages = .loaded(images)
                            self.loadedImages = images
                        }
                    case .failure(let error):
                        DispatchQueue.main.async {
                            self.galleryImages = .failed(error)
                        }
                    }
            }
            
        }
    }
}
