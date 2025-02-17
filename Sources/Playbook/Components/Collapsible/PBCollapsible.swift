//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCollapsible.swift
//

import SwiftUI

public struct PBCollapsible<HeaderContent: View, Content: View>: View {
  @State private var isCollapsed: Bool
  var indicatorPosition: IndicatorPosition
  var indicatorColor: Color
  var headerView: HeaderContent
  var contentView: Content
  var iconSize: PBIcon.IconSize
  var iconColor: CollapsibleIconColor
  var actionButton: PBButton?

  public init(
    isCollapsed: Bool = false,
    indicatorPosition: IndicatorPosition = .leading,
    indicatorColor: Color = .text(.light),
    iconSize: PBIcon.IconSize = .small,
    iconColor: CollapsibleIconColor = .default,
    actionButton: PBButton? = nil,
    @ViewBuilder header: @escaping () -> HeaderContent,
    @ViewBuilder content: @escaping () -> Content
  ) {
    self.isCollapsed = isCollapsed
    self.indicatorPosition = indicatorPosition
    self.indicatorColor = indicatorColor
    self.actionButton = actionButton
    self.headerView = header()
    self.contentView = content()
    self.iconSize = iconSize
    self.iconColor = iconColor
  }

  public var body: some View {
    VStack {
      Button {
        withAnimation {
          isCollapsed.toggle()
        }
      } label: {
        if indicatorPosition == .leading {
          indicator
          headerView
          Spacer()
          if let button = actionButton {
            button
          }
        } else {
          if let button = actionButton {
            button
          }
          headerView
          Spacer()
          indicator
        }
      }
      .tint(indicatorColor)
      .buttonStyle(BorderlessButtonStyle())

      VStack {
        if !isCollapsed {
          contentView
            .padding(.top, Spacing.small)
        }
      }
      .frame(maxWidth: .infinity)
      .fixedSize(horizontal: false, vertical: true)
      .frame(height: isCollapsed ? 0 : .none, alignment: .top)
      .clipped()
    }
  }
}

// MARK: - Extensions

public extension PBCollapsible {
  var indicator: some View {
    PBIcon.fontAwesome(.chevronDown, size: iconSize)
      .foregroundColor(iconColor.iconColor)
      .padding(Spacing.xxSmall)
      .rotationEffect(
        .degrees(isCollapsed ? 0 : 180)
      )
  }

  enum IndicatorPosition {
    case leading
    case trailing
  }
}

public enum CollapsibleIconColor {
  case `default`
  case light
  case lighter
  case link
  case error
  case success

  var iconColor: Color {
    switch self {
      case .`default`: return .text(.default)
      case .light: return .text(.light)
      case .lighter: return .text(.lighter)
      case .link: return .pbPrimary
      case .error: return .status(.error)
      case .success: return .status(.success)
    }
  }
}

public struct PBCollapsible_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()
    return CollapsibleCatalog()
  }
}
