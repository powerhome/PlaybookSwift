//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBIcon.swift
//

import SwiftUI

public protocol PlaybookGenericIcon {
  var unicodeString: String { get }
  var fontFamily: String { get }
}

public struct PBIcon: View {
  var icon: PlaybookGenericIcon
  var size: IconSize
  var color: Color?
  var rotation: IconRotation
  var border: Bool
  var flipped: [Axis]?

  public init(
    _ icon: PlaybookGenericIcon,
    size: IconSize = .x1,
    color: Color? = nil,
    rotation: IconRotation = .zero,
    border: Bool = false,
    flipped: [Axis]? = nil
  ) {
    self.size = size
    self.icon = icon
    self.color = color
    self.rotation = rotation
    self.border = border
    self.flipped = flipped
  }

  public var body: some View {
    if let color = color {
      iconView.foregroundStyle(color)
    } else {
      iconView
    }
  }

  var iconView: some View {
    Text(icon.unicodeString)
      .font(Font.custom(icon.fontFamily, size: size.fontSize))
      .baselineOffset(-0.5)
      .rotationEffect(rotation.angle)
      .padding(.horizontal, border ? 10.5 : 0)
      .padding(.top, border ? 6.4 : 0)
      .padding(.bottom, border ? 4.8 : 0)
      .border(border ? Color.border : .clear, width: 2.5)
      .flipped(flipped)
  }
}

public extension PBIcon {
  enum IconSize: Hashable {
    case xSmall
    case small
    case large
    case x1
    case x2
    case x3
    case x4
    case x5
    case x6
    case x7
    case x8
    case x9
    case x10
    case custom(CGFloat)
    var fontSize: CGFloat {
      let emToPt: CGFloat = 16

      switch self {
      case .xSmall: return 12
      case .small: return 14
      case .large: return 20

      case .x1: return 1 * emToPt
      case .x2: return 2 * emToPt
      case .x3: return 3 * emToPt
      case .x4: return 4 * emToPt
      case .x5: return 5 * emToPt
      case .x6: return 6 * emToPt
      case .x7: return 7 * emToPt
      case .x8: return 8 * emToPt
      case .x9: return 9 * emToPt
      case .x10: return 10 * emToPt
      case .custom(let size): return size
      }
    }
   static var sizeArray: [(IconSize, String)] {
     return [(.xSmall, "XSmall"), (.small, "Small"), (.large, "Large"), (.x1, "1x"), (.x2, "x2"), (.x3, "3x"), (.x4, "4x"), (.x5,     "5x"), (.x6, "6x"), (.x7, "7x"), (.x8, "8x"), (.x9, "9x"), (.x10, "10x"), (.custom(170), "Custom")]
    }
  }

  enum IconRotation {
    case zero
    case right
    case straight
    case obtuse

    var angle: Angle {
      switch self {
      case .zero: return Angle(degrees: 0)
      case .right: return Angle(degrees: 90)
      case .straight: return Angle(degrees: 180)
      case .obtuse: return Angle(degrees: 270)
      }
    }
  }
}

public struct PBIcon_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return IconCatalog()
  }
}

extension View {
  func flipped(_ axis: [Axis]? = nil) -> some View {
    switch axis {
    case [.horizontal]:
      return scaleEffect(CGSize(width: -1, height: 1), anchor: .center)
    case [.vertical]:
      return scaleEffect(CGSize(width: 1, height: -1), anchor: .center)
    case [.horizontal, .vertical], [.vertical, .horizontal]:
      return scaleEffect(CGSize(width: -1, height: -1), anchor: .center)
    default: return scaleEffect(CGSize(width: 1, height: 1), anchor: .center)
    }
  }
}
