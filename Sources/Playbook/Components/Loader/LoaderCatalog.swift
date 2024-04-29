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
  var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default") {
          defaultView
        }
        PBDoc(title: "Solid") {
          solidLoaderView
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
    VStack(spacing: Spacing.small) {
        PBLoader()
    }
  }
  var solidLoaderView: some View {
    VStack(spacing: Spacing.small) {
      PBLoader(
        dotSize: 15,
        isLoaderSolid: true,
        spinnerSpeed: 0.8
      )
    }
  }
}
