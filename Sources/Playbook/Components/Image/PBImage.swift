//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBImage.swift
//

import SwiftUI

public struct PBImage: View {
  let image: Image?
  let placeholder: Image?
  let size: Size?
  let rounded: ImageCornerRadius
  var isActive: Bool
  public init(
    image: Image?,
    placeholder: Image? = nil,
    size: Size? = nil,
    rounded: ImageCornerRadius = .sharp,
    isActive: Bool = true
  ) {
    self.image = image
    self.placeholder = placeholder
    self.size = size
    self.rounded = rounded
    self.isActive = isActive
  }

  public var body: some View {
    if let size = size {
      imageView
        .cornerRadius(rounded.rawValue)
        .frame(width: size.rawValue, height: size.rawValue)
        .grayscale(isActive ? 0 : 1)
    } else {
      imageView
    }
  }

  @ViewBuilder
  private var imageView: some View {
    if let image = image {
      image.resizable()
    } else {
      placeholder?.resizable()
    }
  }
}

public extension PBImage {
  enum Size: CGFloat, CaseIterable {
    case xSmall = 60
    case small = 80
    case medium = 100
    case large = 120
    case xLarge = 140

    var name: String {
      switch self {
      case .xSmall: return "xSmall"
      case .small: return "small"
      case .medium: return "medium"
      case .large: return "large"
      case .xLarge: return "xLarge"
      }
    }
  }

  enum ImageCornerRadius: CGFloat {
    case rounded = 7
    case sharp = 0
  }
}

public struct PBImage_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return ImageCatalog()
  }
}
