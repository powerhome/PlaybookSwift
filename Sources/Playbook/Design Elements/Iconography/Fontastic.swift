//
//  Fontastic.swift
//
//
//  Created by Alexandre da Silva on 18/01/22.
//

import SwiftUI

public enum Fontastic: String, PlaybookGenericIcon, CaseIterable {
  case smilePlus = "smile-plus"

  public var unicodeString: String {
    switch self {
    case .smilePlus: return "\u{0072}"
    }
  }

  public var fontFamily: String { "untitled-font-1" }
}

public extension PBIcon {
  static func fontastic(_ icon: Fontastic, size: IconSize = .x1) -> PBIcon {
    PBIcon(icon, size: size)
  }
}
