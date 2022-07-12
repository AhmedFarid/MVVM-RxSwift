//
//  LoginSuccessModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 11/07/2022.
//

import Foundation

// MARK: - LoginSuccessModel
struct LoginSuccessModel: Codable {
  var success: Bool?
  var data: DataClass?
  var message: String?
}

// MARK: - DataClass
struct DataClass: Codable {
  var token, tokenType: String?
  var user: User?

  enum CodingKeys: String, CodingKey {
      case token
      case tokenType = "token_type"
      case user
  }
}

// MARK: - User
struct User: Codable {
  var id: Int?
  var username, code, firstName, secondName: String?
  var thirdName, jobTitle: String?
  var municipals, districts: [District]?
  var image: String?

  enum CodingKeys: String, CodingKey {
      case id, username, code
      case firstName = "first_name"
      case secondName = "second_name"
      case thirdName = "third_name"
      case jobTitle = "job_title"
      case municipals, districts, image
  }
}

// MARK: - District
struct District: Codable {
  var id: Int?
  var title: String?
}

