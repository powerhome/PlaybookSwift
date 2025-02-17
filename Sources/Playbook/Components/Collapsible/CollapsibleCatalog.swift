//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  CollapsibleCatalog.swift
//

import SwiftUI

public struct CollapsibleCatalog: View {
  struct CollapsibleDoc: View {
    let iconSize: PBIcon.IconSize
    let iconColor: CollapsibleIconColor
    let text: String
    private var isCollapsed = true

    var content: some View {
      Text(lorem).pbFont(.body)
    }

    let lorem =
      """
      Group members... Lorem ipsum dolor sit amet, consectetur adipiscing elit. In vel erat sed purus hendrerit vive.

      Etiam nunc massa, pharetra vel quam id, posuere rhoncus quam. Quisque imperdiet arcu enim, nec aliquet justo.

      Praesent lorem arcu. Vivamus suscipit, libero eu fringilla egestas, orci urna commodo arcu, vel gravida turpis.
      """

    public init(
      iconSize: PBIcon.IconSize = .small,
      iconColor: CollapsibleIconColor = .default,
      text: String
    ) {
      self.iconSize = iconSize
      self.iconColor = iconColor
      self.text = text
    }

    var body: some View {
      PBCollapsible(isCollapsed: isCollapsed, iconSize: iconSize, iconColor: iconColor) {
        Text(text).pbFont(.body)
      } content: {
        content
      }
    }
  }

  public var body: some View {
    PBDocStack(title: "Collapsible") {
      PBDoc(title: "Default") {
        CollapsibleDoc(text: "Main Section")
      }

      PBDoc(title: "Size") {
        VStack(spacing: Spacing.medium) {
          CollapsibleDoc(iconSize: .xSmall, text: "Extra Small Section")
          CollapsibleDoc(iconSize: .small, text: "Small Section")
          CollapsibleDoc(text: "Default Section")
          CollapsibleDoc(iconSize: .large, text: "Large Section")
        }
      }

      PBDoc(title: "Color") {
        VStack(spacing: Spacing.medium) {
          CollapsibleDoc(iconColor: .default, text: "Default Section")
          CollapsibleDoc(iconColor: .light, text: "Light Section")
          CollapsibleDoc(iconColor: .lighter, text: "Lighter Section")
          CollapsibleDoc(iconColor: .link, text: "Link Section")
          CollapsibleDoc(iconColor: .error, text: "Error Section")
          CollapsibleDoc(iconColor: .success, text: "Success Section")
        }
      }
    }
  }
}
