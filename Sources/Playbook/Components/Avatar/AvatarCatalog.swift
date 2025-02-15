//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  AvatarCatalog.swift
//

import SwiftUI

public struct AvatarCatalog: View {
  public var body: some View {
    PBDocStack(title: "Avatar") {
      PBDoc(title: "Default") {
        defaultAvatars
      }
      PBDoc(title: "Monogram") {
        monograms
      }
      PBDoc(title: "Status Size") {
        statusSize
      }
      PBDoc(title: "Status color") {
        statusColor
      }
      PBDoc(title: "Greyscale") {
        greyScale
      }
    }
  }
}

extension AvatarCatalog {
  var defaultAvatars: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .xxSmall, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away)
      PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .online)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xLarge, status: .offline)
    }
  }
  
  var monograms: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(name: "Tim Wenhold", size: .xxSmall, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .xSmall, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .small, status: .online)
      PBAvatar(name: "Tim Wenhold", size: .medium, status: .away)
      PBAvatar(name: "Tim Wenhold", size: .large, status: .online)
      PBAvatar(name: "Tim", size: .xLarge, status: .offline)
    }
  }
  
  var statusSize: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online, statusSize: .medium)
        Text("Small").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away, statusSize: .medium)
        Text("Medium").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .offline, statusSize: .medium)
        Text("Large").pbFont(.caption)
      }
    }
  }

  var statusColor: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .online, statusSize: .medium)
        Text("Online").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away, statusSize: .medium)
        Text("Away").pbFont(.caption)
      }
      VStack(spacing: Spacing.xxSmall) {
        PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .offline, statusSize: .medium)
        Text("Offline").pbFont(.caption)
      }
    }
  }

  var greyScale: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(image: Image("andrew", bundle: .module), size: .xxSmall, status: .online, isActive: false)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xSmall, status: .away, isActive: false)
      PBAvatar(image: Image("andrew", bundle: .module), size: .small, status: .online, isActive: false)
      PBAvatar(image: Image("andrew", bundle: .module), size: .medium, status: .away, isActive: false)
      PBAvatar(image: Image("andrew", bundle: .module), size: .large, status: .online, isActive: false)
      PBAvatar(image: Image("andrew", bundle: .module), size: .xLarge, status: .offline, isActive: false)
    }
  }
}

#Preview {
  AvatarCatalog()
}
