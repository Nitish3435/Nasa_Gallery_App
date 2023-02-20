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
    func checkApiStatus(completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
        getGalleryImagesUseCase.galleryRepository.checkAPIStatus { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
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

