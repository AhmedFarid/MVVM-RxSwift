//
//  UserViewModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import Foundation

enum UserValidationState {
  case Valid
  case Invalid(String)
}

class UserViewModel {
  private let minUsernameLength = 4
  private let minPasswordLength = 5
  private let codeRefreshTime = 5.0
  
  private var user = UserLogin() {
    didSet {
      username.value = user.username
      
    }
  }
  
  var username: Box<String> = Box("")
  
  var password: Box<String> = Box("")
  
  var accessCode: Box<String?> = Box(nil)
  
  var protectedUserName: String {
    let characters = username
    
    if characters.value.count >= minUsernameLength {
      var displayName = [Character]()
      for (index, character) in characters.value.enumerated() {
        if index > characters.value.count - minUsernameLength {
          displayName.append(character)
        }else {
          displayName.append("*")
        }
      }
      return String(displayName)
    }
    return username.value
  }
  
  init(user: UserLogin = UserLogin()) {
    self.user = user
    startAccessCodeTimer()
  }
}

extension UserViewModel {
  func updateUsername(username: String) {
    user.username = username
  }
  
  func updatePassword(password: String) {
    user.password = password
  }
  
  func validate() -> UserValidationState {
    if user.username.isEmpty || user.password.isEmpty {
      return .Invalid("User Name and password are required.")
    }
    
    if user.username.count < minUsernameLength {
      return .Invalid("User Name needs to be at lest \(minUsernameLength) characters long.")
    }
    
    if user.password.count < minPasswordLength {
      return .Invalid("Password needs to be at lest \(minPasswordLength) characters long.")
    }
    return .Valid
  }
  
  func login(completion: (_ errorString: String?)->Void) {
    LoginService.loginWithUsername(username: user.username, password: user.password) { success in
      if success {
        completion(nil)
      }else {
        completion("Invalid Credentials.")
      }
    }
  }
}

private extension UserViewModel {
  func startAccessCodeTimer() {
    accessCode.value = LoginService.generateAccessCode()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + codeRefreshTime) {[weak self] in
      guard let self = self else {return}
      self.startAccessCodeTimer()
    }
  }
}
