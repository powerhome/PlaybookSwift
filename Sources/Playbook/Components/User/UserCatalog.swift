//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  UserCatalog.swift
//

import SwiftUI

public struct UserCatalog: View {
  let img = Image("andrew", bundle: .module)
  let name = "Andrew K"
  let title = "Rebels Developer"
  public var body: some View {
    ScrollView {
      VStack(spacing: Spacing.medium) {
        PBDoc(title: "Horizontal") {
          userHorizontalView
        }

        PBDoc(title: "Vertical") {
          userVerticalView
        }

        PBDoc(title: "Text Only") {
          userTextOnlyView
        }

        PBDoc(title: "Horizontal Sizes") {
          userHorizontalSizesView
        }
        
        PBDoc(title: "Block Content Subtitle") {
          userSubtitleBlockView
        }
      }
      .padding(Spacing.medium)
    }
    .background(Color.background(Color.BackgroundColor.light))
    .navigationTitle("User")
  }
}

public extension UserCatalog {
  var userHorizontalView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: name,
        image: img,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        image: img,
        size: .small,
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        image: img,
        size: .small,
        subtitle: {}
      )
    }
  }
  
  var userVerticalView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        size: .small,
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        image: img,
        orientation: .vertical,
        size: .large,
        title: title,
        subtitle: {}
      )
    }
  }
  
  var userTextOnlyView: some View {
    return VStack(spacing: Spacing.small) {
      PBUser(
        name: name,
        displayAvatar: false,
        size: .large,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        displayAvatar: false,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
    }
  }
  
  var userHorizontalSizesView: some View {
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: name,
        image: img,
        size: .small,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        image: img,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
      PBUser(
        name: name,
        image: img,
        size: .large,
        territory: "PHL",
        title: title,
        subtitle: {}
      )
    }
  }
  
  var userSubtitleBlockView: some View {
    let contacts = [
      PBContact(type: .cell, value: "(349) 185-9988", detail: false),
      PBContact(type: .home, value: "(555) 555-5555", detail: false),
      PBContact(type: .email, value: "email@example.com", detail: false)
    ]
    return VStack(alignment: .leading, spacing: Spacing.small) {
      PBUser(
        name: "Anna Black",
        image: Image("Anna", bundle: .module),
        size: .small, 
        territory: "PHL",
        title: "Remodeling Consultant",
        subtitle: {
          HStack {
            PBIcon(FontAwesome.users, size: .small)
            Text("ADMIN")
              .pbFont(.caption, color: .text(.light))
          }
        }
      )
      PBUser(
        name: "Anna Black",
        image: Image("Anna", bundle: .module),
        size: .small,
        subtitle: {
          ForEach(contacts, id: \.parsedValue) { contact in
                PBContact(type: contact.type, value: contact.contactValue, detail: contact.detail)
              }
        }
      )
    }
  }
}
