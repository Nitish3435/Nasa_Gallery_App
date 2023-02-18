//
//  GalleryUseCase.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation

class GalleryUseCase {
    var getGalleryImagesUseCase: GetGalleryImagesUseCase
    init(galleryRepository: GalleryRepository) {
        self.getGalleryImagesUseCase = GetGalleryImagesUseCase(galleryRepository: galleryRepository)
    }
}
extension GalleryUseCase {
    struct GetGalleryImagesUseCase: UseCase {
        var galleryRepository: GalleryRepository
        func execute(data: String, completion: @escaping (Result<[ImageModel], Error>) -> Void) {
            galleryRepository.fetchGalleryPhotos { result in
                switch result {
                case .success(let photos):
                    completion(.success(photos))
                    return
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
    }
}

