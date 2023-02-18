//
//  GalleryRepositoryImplementation.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation

class GalleryRepositoryImplementation: GalleryRepository {
    var galleryImages: [ImageModel] = []
    func fetchGalleryPhotos(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "data", withExtension: "json")
            else {
                return
            }

        let data = try? Data(contentsOf: url)
        guard let data = data else {
            return
        }
        let users = try? JSONDecoder().decode([ImageModel].self, from: data)
        galleryImages = users ?? []
        completion(.success(galleryImages))

    }
}
