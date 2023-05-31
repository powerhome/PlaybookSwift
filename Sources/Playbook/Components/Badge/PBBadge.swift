//
//  PBBadge.swift
//
//
//  Created by Alexandre Hauber on 22/07/21.
//

import SwiftUI

public struct PBBadge: View {
  var text: String
  var rounded: Bool
  var variant: Variant

  public init(text: String, rounded: Bool = false, variant: Variant = .primary) {
    self.text = text
    self.rounded = rounded
    self.variant = variant
  }

  public var body: some View {
    Text(text)
      .padding(EdgeInsets(top: 2.5, leading: 4, bottom: 1.5, trailing: 4))
      .frame(minWidth: 8)
      .foregroundColor(variant.foregroundColor())
      .background(variant.backgroundColor())
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

    func foregroundColor() -> Color {
      switch self {
      case .chat: return .white
      case .error: return .status(.error)
      case .info: return .status(.info)
      case .neutral: return .status(.neutral)
      case .success: return .text(.successSmall)
      case .warning: return .status(.warning)
      default: return .pbPrimary
      }
    }

    func backgroundColor() -> Color {
      if self == .chat {
        return Color.pbPrimary
      } else {
        return foregroundColor().opacity(0.12)
      }
    }
  }
}

struct PBBadge_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    return BadgeCatalog()
      .background(Color.white)
  }
}
