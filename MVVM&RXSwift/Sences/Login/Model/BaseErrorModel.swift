//
//  BaseErrorModel.swift
//  MVVM&RXSwift
//
//  Created by macbook on 11/07/2022.
//

import Foundation

struct BaseErrorModel: Codable {
  var success: Bool?
  var error: ErrorLogin?
  var message: String?
}
 
struct ErrorLogin: Codable {
  var failed: [String]?
}
