//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PositionCatalog.swift
//

import SwiftUI

public struct GlobalPositionCatalog: View {
  @State private var selected: Int = 1
  @State private var contentSize: CGSize = .zero
  
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Default", spacing: Spacing.small) {
          avatarStatusView
        }
        PBDoc(title: "Image", spacing: Spacing.small) {
          imageBadgeView
        }
        PBDoc(title: "Card With Badge", spacing: Spacing.small) {
          cardWithBadgeView.padding(Spacing.xxSmall)
        }
        PBDoc(title: "Nav", spacing: Spacing.small) {
          navView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("Global Position")
  }
}

extension GlobalPositionCatalog {
  var avatarStatusView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBAvatar(
        image: Image("andrew", bundle: .module),
        size: .small
      )
      .globalPosition(
        alignment: .bottom
      ) {
        PBBadge(text: "On Roadtrip", rounded: true, variant: .chat)
      }

      PBAvatar(
        image: Image("Anna", bundle: .module),
        size: .medium
      )
      .globalPosition(alignment: .topLeading) {
        PBBadge(
          text: "3",
          rounded: true,
          variant: .chat
        )
      }
      
      PBAvatar(
        image: Image("Lu", bundle: .module),
        size: .large
      )
      .globalPosition(
        alignment: Alignment.bottom,
        bottom: -Spacing.xxSmall
      ) {
        PBBadge(
          text: "On Roadtrip",
          rounded: true,
          variant: .chat
        )
      }
    }
  }
  
  var imageBadgeView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      PBImage(
        image: nil,
        placeholder: Image("Forest", bundle: .module),
        size: .xSmall,
        rounded: .sharp
      )
      .globalPosition(
        alignment: .topTrailing,
        top: -Spacing.xSmall, 
        trailing: -Spacing.xxSmall
        
      ) {
        PBBadge(
          text: "3",
          rounded: true,
          variant: .chat
        )
      }
    }
  }
  
  var cardWithBadgeView: some View {
    VStack(spacing: Spacing.small) {
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .globalPosition(
        alignment: .bottomLeading,
        isCard: true
      ) {
        PBBadge(
          text: "+1",
          rounded: false,
          variant: .primary
        )
        .background(Color.white)
      }
      
      PBCard{
        Text("A bunch of awesome content goes here. ")
      }
      .globalPosition(
        alignment: .bottomLeading,
        isCard: true
      ) {
        PBIconCircle(
          FontAwesome.rocket,
          size: .small,
          color: .data(.data5)
        )
        .background(Color.white)
      }
    }
  }
  
  var navView: some View {
    PBNav(
      selected: $selected,
      variant: .normal,
      orientation: .horizontal
    ) {
      PBNavItem("First")
        .globalPosition(
          alignment: .topTrailing,
          top: 0,
          leading: -Spacing.medium,
          bottom: 0,
          trailing: 0
        ) {
          PBBadge(
            text: "3",
            rounded: true,
            variant: .chat
          )
        }
      PBNavItem("Second")
      PBNavItem("Third")
    }
  }
}

#Preview {
  registerFonts()
  return GlobalPositionCatalog()
}
