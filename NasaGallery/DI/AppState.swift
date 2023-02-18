//
//  AppState.swift
//  NasaGallery
//
//  Created by Nitish Kumar on 18/02/23.
//

import Foundation

class AppState {
  var system = System()
  var authentication = Authentication()
}

extension AppState {
  struct System {
    // tokens, keys, user information
    var isActive = false
    var hasInternet = true
  }
}

extension AppState {
  struct Authentication {
    var hasToken = false
  }
}

// #if DEBUG
extension AppState {
  static var preview: AppState {
    let state = AppState()
    state.system.isActive = true
    return state
  }
}
// #endif

