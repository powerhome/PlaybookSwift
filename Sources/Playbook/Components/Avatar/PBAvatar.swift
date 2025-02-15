//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBAvatar.swift
//

import SwiftUI

public struct PBAvatar: View {
  var image: Image?
  var name: String?
  var size: Size
  var status: PBOnlineStatus.Status?
  var statusSize: PBOnlineStatus.Size
  var wrapped: Bool
  var isActive: Bool
  @Environment(\.colorScheme) var colorScheme
  
  public init(
    image: Image? = nil,
    name: String? = nil,
    size: Size = .medium,
    status: PBOnlineStatus.Status? = nil,
    statusSize: PBOnlineStatus.Size = .small,
    wrapped: Bool = false,
    isActive: Bool = true
  ) {
    self.image = image
    self.name = name
    self.size = size
    self.status = status
    self.statusSize = statusSize
    self.wrapped = wrapped
    self.isActive = isActive
  }

  public var body: some View {
    ZStack {
      Group {
        if let image = image {
          image
            .resizable()
            .aspectRatio(contentMode: .fit)
        } else if let initials = initials {
          Text(initials)
            .pbFont(.monogram(size.fontSize), color: .white)
        }
      }
      .foregroundColor(.white)
      .grayscale(isActive ? 0 : 1)
      .frame(width: size.diameter, height: size.diameter)
      .background(Color.status(.neutral))
      .clipShape(Circle())

      if wrapped {
        Circle()
          .strokeBorder(avatarBorderColor, lineWidth: 1)
          .frame(width: size.diameter + 1, height: size.diameter + 1)
      }

      
      if let status = self.status {
        PBOnlineStatus(status: status, size: statusSize, variant: .border)
          .grayscale(isActive ? 0 : 1)
          .offset(
            x: (size.diameter/2 - size.diameter/9) * size.statusXModifier,
            y: (size.diameter/2 - size.diameter/6) * size.statusYModifier
          )
      }
    }
  }
}

public extension PBAvatar {
  var initials: String? {
    guard let name = name else { return nil }
    let names = name.split(separator: " ")

    if let firstNameInitial = String(names.first ?? " ").first {
      if names.count == 1 {
        return "\(firstNameInitial.uppercased())"
      } else if let lastNameInitial = String(names.last ?? " ").first {
        return "\(firstNameInitial.uppercased())\(lastNameInitial.uppercased())"
      }
    }
    return nil
  }

  enum Size: CaseIterable, Hashable {
    public static var allCases: [PBAvatar.Size] = []
    case xxSmall
    case xSmall
    case small
    case medium
    case large
    case xLarge
    case defaultStacked
    case defaultStackedIndicator
    case smallStacked
    case smallStackedIndicator
    case custom(_ size: CGFloat)
    
    var diameter: CGFloat {
      switch self {
      case .xxSmall: return 20
      case .xSmall: return 28
      case .small: return 38
      case .medium: return 60
      case .large: return 80
      case .xLarge: return 100
      case .defaultStacked: return 34
      case .defaultStackedIndicator: return 18
      case .smallStacked: return 22
      case .smallStackedIndicator: return 16
      case .custom(let size): return size
      }
    }

    var fontSize: CGFloat {
      return diameter * 0.38
    }

    var statusXModifier: CGFloat {
      switch self {
      case .xxSmall: return 1.3
      case .xSmall: return 1.2
      case .small: return 0.95
      case .medium: return 1.05
      case .large: return 1.12
      case .xLarge: return 1.16
      default: return 0
      }
    }

    var statusYModifier: CGFloat {
      switch self {
      case .xxSmall: return -0.8
      case .xSmall: return -1
      case .small: return -1.1
      case .medium: return 1
      case .large: return 0.78
      case .xLarge: return 0.68
      default: return 0
      }
    }

    var avatarCases: [Size] {
      [.xLarge, .large, .medium, .small, .xSmall, .xxSmall]
    }
  }
  
  var avatarBorderColor: Color {
    switch colorScheme {
    case .light: return Color.BorderColor.borderColor(.light)
    case .dark: return Color.BorderColor.borderColor(.dark)
    default:
      return Color.white
      
    }
  }
}

#Preview {
  PBAvatar(
    image: Image("andrew", bundle: .module),
    size: .xLarge,
    status: .online
  )
}
