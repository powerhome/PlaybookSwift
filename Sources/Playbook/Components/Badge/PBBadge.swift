//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBBadge.swift
//

import SwiftUI

public struct PBBadge: View {
  var text: String
  var rounded: Bool
  var variant: Variant
  @Environment(\.colorScheme) var colorScheme
  public init(
    text: String,
    rounded: Bool = false,
    variant: Variant = .primary
  ) {
    self.text = text
    self.rounded = rounded
    self.variant = variant
  }
  
  public var body: some View {
    Text(text)
      .padding(EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4))
      .frame(minWidth: 8)
      .foregroundColor(foregroundColor())
      .background(backgroundColor())
      .background(.white)
      .pbFont(.badgeText)
      .cornerRadius(rounded ? 9 : 4)
  }
}

public extension PBBadge {
  enum Variant: CaseIterable {
    case chat
    case error
    case info
    case neutral
    case primary
    case success
    case warning
  }
  func foregroundColor() -> Color {
    switch variant {
    case .chat: return .white
    case .error: return .status(.error)
    case .info: return .status(.info)
    case .neutral: return colorScheme == .dark ? .black.opacity(0.55) : .text(.light)
    case .success: return .text(.successSmall)
    case .warning: return .status(.warning)
    default: return .pbPrimary
    }
  }
  
  func backgroundColor() -> Color {
    if variant == .chat {
      return Color.pbPrimary
    } else {
      return foregroundColor().opacity(0.12)
    }
  }
}

#Preview {
  registerFonts()
  return PBBadge(text: "+1000", variant: .primary)
}
