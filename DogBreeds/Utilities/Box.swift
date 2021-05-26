//
//  Box.swift
//  DogBreeds
//
//  Created by Suman Kumar Konakalla on 5/26/21.
//

import Foundation

//Data binding using Box
final class Box<T> {
  
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
