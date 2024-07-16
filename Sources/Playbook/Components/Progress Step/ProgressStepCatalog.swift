//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ProgressStepCatalog.swift
//

import SwiftUI

public struct ProgressStepCatalog: View {
  @State private var progress: Int = 1
  @State private var progress1: Int = 1
  public var body: some View {
    PBDocStack(title: "Progress Step", spacing: Spacing.medium) {
      PBDoc(title: "Default") {
        defaultView
      }
      
      Button(action: {
          progress += 1
        progress1 += 1
                 }) {
                     Text("Submit")
                         .padding()
                         .background(Color.blue)
                         .foregroundColor(.white)
                         .cornerRadius(8)
                 }
                 .padding(.top, 50)
    }
  }
}

extension ProgressStepCatalog {
  var defaultView: some View {
      VStack(alignment: .leading, spacing: Spacing.medium) {
        PBProgressStep(
          progress: $progress
        )
        PBProgressStep(
          hasIcon: false,
          label: "Step",
          showLabelIndex: true,
          progress: $progress1
        )
      }
      .padding(.bottom, 30)
  }
}
#Preview {
  registerFonts()
  return ProgressStepCatalog()
}
