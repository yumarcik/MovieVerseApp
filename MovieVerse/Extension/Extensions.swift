//
//  Extensions.swift
//  MovieVerse
//
//  Created by Yağmur Polat on 3.05.2022.
//

import Foundation
import UIKit

public extension Collection where Indices.Iterator.Element == Index {

  subscript (safe index: Index) -> Iterator.Element? {
    return indices.contains(index) ? self[index] : nil
  }
}
