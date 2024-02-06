//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBDialogHeaderView.swift
//

import SwiftUI

struct PBDialogHeaderView: View {
  let title: String?
  let dismissAction: (() -> Void)

  public init(title: String?, dismissAction: @escaping () -> Void) {
    self.title = title
    self.dismissAction = dismissAction
  }

  var body: some View {
    HStack {
      if let title = title {
        Text(title).pbFont(.body).padding(Spacing.small)
      }
      Spacer()
      Button {
        dismissAction()
      } label: {
        PBIcon(FontAwesome.times, size: .x1)
          .foregroundColor(.text(.default))
      }
      .buttonStyle(.borderless)
      .padding()
    }
  }
}

struct PBDialogHeaderView_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()
    return PBDialogHeaderView(title: "Dialog Header", dismissAction: {})
  }
}
