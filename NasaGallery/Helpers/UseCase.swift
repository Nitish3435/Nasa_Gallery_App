//
//  UseCase.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation

protocol UseCase {
    associatedtype Input
    associatedtype Output
    func execute(data: Input, completion: @escaping (Output) -> Void)
}
