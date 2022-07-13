//
//  APIServiceV2.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import Foundation

enum APIError: String,Error {
  case noNetwork = "NoNetWork"
  case serverOverload = "Server is overload"
  case permissionDenied = "You don't have permission"
}

protocol APIServiceProtocol {
  func fetchPopularPhoto(complete: @escaping (_ success: Bool,_ photos: [Photo],_ error:APIError?)->())
}

class APIServiceV2: APIServiceProtocol {
  func fetchPopularPhoto(complete: @escaping (Bool, [Photo], APIError?) -> ()) {
    DispatchQueue.global().async {
      sleep(3)
      let path = Bundle.main.path(forResource: "content", ofType: "json")!
      let data = try! Data(contentsOf: URL(fileURLWithPath: path))
      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601
      let photos = try! decoder.decode(Photos.self, from: data)
      complete(true,photos.photos,nil)
    }
  }
}
