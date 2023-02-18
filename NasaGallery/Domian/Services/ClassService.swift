//
//  ClassService.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation
import Combine

protocol ClassService {
  func load(classDetail: LoadableSubject<String>)
}
struct MockClassService: ClassService {
  func load() {
  }
  func load(classDetail: LoadableSubject<String>) {
    let cancelBag = CancelBag()
    classDetail.wrappedValue.setIsLoading(cancelBag: cancelBag)
    loadClass(with: 3, classDetail: classDetail)
  }
  func loadClass(with delay: Double, classDetail: LoadableSubject<String>) {
    _ = Timer.scheduledTimer(withTimeInterval: delay, repeats: false) { _ in
        classDetail.wrappedValue = .loaded("")
    }
  }
}
