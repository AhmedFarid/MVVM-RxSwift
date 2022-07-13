//
//  LoginService.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import Foundation
 
struct LoginService {
  static var isAuthenticated = false

  static func loginWithUsername(username: String, password: String, completion: (Bool) -> Void) {
    if username == "Ahmed" && password == "swift" {
      isAuthenticated = true
      completion(true)
    } else {
      completion(false)
    }
  }

  static func logout(completion: () -> Void) {
    isAuthenticated = false
    completion()
  }

  static func generateAccessCode() -> String {
    let components = NSUUID().uuidString.split { $0 == "-" }.map(String.init)
    return components.first!
  }
}
