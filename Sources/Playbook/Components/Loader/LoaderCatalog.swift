//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  LoaderCatalog.swift
//

import SwiftUI

struct LoaderCatalog: View {
  @State private var rotationAngle: Double = 0
    var body: some View {
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBDoc(title: "Default") {
            defaultView
          }
        }
        .padding(Spacing.medium)
      }
      .background(Color.background(Color.BackgroundColor.light))
      .navigationTitle("Loader")
    }
}

extension LoaderCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      HStack {
        PBLoader(rotationAngle: $rotationAngle)
      }
      .frame(maxWidth: .infinity, alignment: .leading)
      HStack {
        PBLoader(rotationAngle: $rotationAngle)
      }
      .frame(maxWidth: .infinity, alignment: .center)
      HStack {
        PBLoader(rotationAngle: $rotationAngle)
      }
      .frame(maxWidth: .infinity, alignment: .trailing)
    }
  }
}
