//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCheckboxStyle.swift
//

import SwiftUI

public struct PBCheckboxStyle: ToggleStyle {
  @Binding var checked: Bool
  @State private var isHovering = false
  var checkboxType: PBCheckbox.CheckboxType
  let action: (() -> Void)?

  public func makeBody(configuration: Configuration) -> some View {
    HStack(spacing: Spacing.xSmall) {
      ZStack {
        RoundedRectangle(cornerRadius: 4)
          .strokeBorder(borderColor, lineWidth: 2)
          .background(backgroundColor)
          .background(isHovering ? Color.hover : Color.clear)
          .clipShape(RoundedRectangle(cornerRadius: 4))
          .frame(width: 22, height: 22)

        switch (checked, checkboxType) {
        case (true, .indeterminate):
          PBIcon.fontAwesome(.minus, size: .small)
            .foregroundColor(.white)
        case (false, _): EmptyView()
        default:
          PBIcon.fontAwesome(.check, size: .small)
            .foregroundColor(.white)
        }
      }

      configuration.label
        .foregroundColor(checkboxType == .error ? .status(.error) : .text(.default))
        .pbFont(.body)
    }
    .frame(minHeight: 22)
    .contentShape(Rectangle())
    .onHover(disabled: false) {
      isHovering = $0
    }
    .onTapGesture {
      checked.toggle()
      action?()
    }
  }

  var borderColor: Color {
    switch (checkboxType, checked) {
    case (.default, true), (.error, true), (.indeterminate, true): return .pbPrimary
    case (.error, false): return .status(.error)
    default: return Color.border
    }
  }

  var backgroundColor: Color {
    checked ? .pbPrimary : .clear
  }
}
