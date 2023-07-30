//
//  PhysicsCategory.swift
//  Monkey Banana
//
//  Created by Abdelrahman Rafaat on 30/07/2023.
//

import Foundation

struct PhysicsCategory {
  static let none      : UInt32 = 0
  static let all       : UInt32 = UInt32.max
  static let monkey    : UInt32 = 0b1
  static let banana    : UInt32 = 0b10
  static let screenEdge: UInt32 = 0b100
}
