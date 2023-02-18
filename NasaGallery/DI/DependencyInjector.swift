//
//  DependencyInjector.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation
import SwiftUI
import Combine

// MARK: - DIContainer

struct DIContainer: EnvironmentKey {
  let appState: Store<AppState>
  let services: Services
  let useCases: UseCases
  static var defaultValue: Self { Self.default }
  private static let `default` = DIContainer(appState: AppState(), services: .mock, useCases: .mock)
  init(appState: Store<AppState>, services: DIContainer.Services, useCases: DIContainer.UseCases) {
    self.appState = appState
    self.services = services
    self.useCases = useCases
  }
  init(appState: AppState, services: DIContainer.Services, useCases: DIContainer.UseCases) {
    self.init(appState: Store(appState), services: services, useCases: useCases)
  }
}

extension DIContainer {
  struct UseCases {
      let galleryUseCase: GalleryUseCase
    static var mock: Self {
        .init(
            galleryUseCase: GalleryUseCase(
                galleryRepository: GalleryRepositoryImplementation())
        )
    }
  }
  struct Services {
    let classService: ClassService
    init(classService: ClassService) {
      self.classService = classService
    }
    static var mock: Self {
      .init(classService: MockClassService())
    }
  }
}

