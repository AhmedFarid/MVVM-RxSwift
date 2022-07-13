//
//  Box.swift
//  MVVM&RXSwift
//
//  Created by macbook on 13/07/2022.
//

import Foundation

class Box<T> {
  typealias Listener = (T) -> Void
  var listener: Listener?

  var value: T {
    didSet {
      listener?(value)
    }
  }

  init(_ value: T) {
    self.value = value
  }

  func bind(listener: Listener?) {
    self.listener = listener
    listener?(value)
  }
}
