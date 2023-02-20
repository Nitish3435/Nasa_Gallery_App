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
        if let url = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json") {
              let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                  if let error = error {
                      completion(.failure(error))
                  }
                  if let data = data {
                      let galleryImages = try? JSONDecoder().decode([ImageModel].self, from: data)
                      self.galleryImages = galleryImages ?? []
                      completion(.success(self.galleryImages))
                  }
              }
              urlSession.resume()
          }
    }

    func checkAPIStatus(completion: @escaping (Result<HTTPURLResponse, Error>) -> Void) {
        if let url = URL(string: "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk/nasa-pictures.json") {
              let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                  if let error = error {
                      completion(.failure(error))
                  }
                  if let response = response as? HTTPURLResponse {

                      completion(.success(response))
                  }
              }
              urlSession.resume()
          }
    }
}
