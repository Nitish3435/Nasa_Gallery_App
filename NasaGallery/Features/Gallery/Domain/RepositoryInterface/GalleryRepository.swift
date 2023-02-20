//
//  GalleryRepository.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation

protocol GalleryRepository {
    func fetchGalleryPhotos(completion: @escaping (Result<[ImageModel], Error>) -> Void)
    func checkAPIStatus(completion: @escaping (Result<HTTPURLResponse, Error>) -> Void)
}
