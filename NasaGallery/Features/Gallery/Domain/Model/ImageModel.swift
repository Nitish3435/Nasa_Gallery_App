//
//  ImageModel.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation
struct Response: Decodable {
    var images: [ImageModel]
}
struct ImageModel: Identifiable, Codable, Hashable {
    var copyRight: String?
    var date: String = ""
    var explanation: String = ""
    var hdurl: String = ""
    var mediaType: String = ""
    var serviceVersion: String = ""
    var title: String = ""
    var url: String = ""
    var id = UUID()
    enum CodingKeys: String, CodingKey {
        case copyRight = "copyright"
        case date
        case explanation
        case hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title
        case url
     }
}
