//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+AttributedString.swift
//

import SwiftUI

extension View {
  func colorAttributedText(_ text: String, characterToChange: String, color: Color) -> AttributedString {
    var attributedString = AttributedString(text)
    var words = text.components(separatedBy: " ")
    words.append(contentsOf: text.components(separatedBy: "\n"))
    for word in words.filter({ $0.hasPrefix(characterToChange) }) {
      guard let range = attributedString.range(of: word) else { return attributedString }
      attributedString[range].foregroundColor = color
    }
    return attributedString
  }
}
