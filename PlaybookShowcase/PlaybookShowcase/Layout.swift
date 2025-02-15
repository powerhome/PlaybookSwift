//
//  Playbook Swift Design System
//
//  Copyright © 2025 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Layout.swift
//

import SwiftUI
import Playbook

struct LayoutView: View {
  let users = Mocks.multipleUsersGroup
  @State var selectedLayout: Int = Layout.classic.layoutIndex
  @State private var hoveringItem: String?
  @State private var hoveringIndex: Int?

  var body: some View {
    VStack(alignment: .leading, spacing: Spacing.none) {
      PBNav(selected: $selectedLayout, variant: .subtle, orientation: .horizontal, borders: false, highlight: false) {
        PBNavItem(Layout.classic.title)
        PBNavItem(Layout.cozy.title)
      }
      ScrollView {
        VStack(spacing: Spacing.medium) {
          PBCollapsible(
            isCollapsed: true,
            iconSize: .small,
            iconColor: .lighter,
            actionButton: PBButton(variant: .link, icon: PBIcon.fontAwesome(.plus)) {}
          ) {
            Text("Rooms").pbFont(.body)
            Spacer()
          } content: {
            roomContent
          }
          PBCollapsible(
            isCollapsed: false,
            iconSize: .small,
            iconColor: .lighter,
            actionButton: PBButton(variant: .link, icon: PBIcon.fontAwesome(.plus)) {}
          ) {
            Text("People").pbFont(.body)
            Spacer()
          } content: {
            peopleContent
          }
        }
        .padding(.horizontal)
      }
      Spacer()
    }
    .background(Color.background(.default))
  }
}

extension LayoutView {
  static let rooms = ["S.H.I.E.L.D", "System Operations", "Birds of Prey", "UX Nitro", "Incredibles", "Home Tour"]

  enum Layout: CaseIterable {
    case classic, cozy

    var title: String {
      switch self {
        case .classic: return "Classic"
        case .cozy: return "Cozy"
      }
    }

    var layoutIndex: Int {
      switch self {
        case .classic: return 0
        case .cozy: return 1
      }
    }
  }

  var roomIconSize: PBIcon.IconSize {
    switch Layout.allCases[selectedLayout] {
      case .classic: return .x1
      case .cozy: return .xSmall
    }
  }

  var roomContent: some View {
    VStack(spacing: Spacing.xSmall) {
      ForEach(LayoutView.rooms, id: \.self) { room in
        roomRow(room: room)
          .background(hoveringItem == room ? Color.active : .clear)
          .onHover { isHovering in
            self.hoveringItem = room
          }
      }
    }
  }

  func roomRow(room: String) -> some View {
    HStack {
      PBIconCircle(FontAwesome.lock, size: roomIconSize, color: .blue)
      Text(room).pbFont(.body)
      Spacer()
      PBBadge(text: "1", rounded: true, variant: .chat)
    }
  }

  var peopleContent: some View {
    VStack(spacing: Spacing.xSmall) {
      ForEach(users.indices, id: \.self) { index in
        let users = users[index]
        peopleRoow(users: users)
          .background(hoveringIndex == index ? Color.active : .clear)
          .onHover { _ in
            self.hoveringIndex = index
          }
      }
    }
  }

  func peopleRoow(users: [PBUser]) -> some View {
    HStack {
      if users.count > 1 {
        multipleUserView(users: users)
      } else {
        singleUserView(user: users[0])
      }
      Spacer()
      PBBadge(text: "1", rounded: true, variant: .chat)
    }
  }

  func multipleUserView(users: [PBUser]) -> some View {
    HStack(spacing: Spacing.small) {
      switch Layout.allCases[selectedLayout] {
        case .classic:
          PBMultipleUsersStacked(users: Mocks.multipleUsers, size: .small)
        case .cozy:
          PBIcon(FontAwesome.users, color: .text(.default))
      }
      let userNames = users.map { $0.name }.prefix(2).joined(separator: ", ")
      Text(userNames).pbFont(.title4)
    }
    .padding(.bottom, Spacing.xxSmall)
    .padding(.trailing, Spacing.xxSmall)
  }

  @ViewBuilder
  func singleUserView(user: PBUser) -> some View {
    switch Layout.allCases[selectedLayout] {
      case .classic:
        PBUser(
          name: user.name,
          image: user.image ?? Image("ana"),
          orientation: .horizontal,
          size: .small,
          title: user.title,
          status: user.status,
          displayAvatar: true
        )
      case .cozy:
        HStack {
          PBOnlineStatus(status: user.status)
            .padding(.leading, Spacing.xxSmall+1)
            .padding(.trailing, Spacing.small)
          Text(user.name).pbFont(.body)
        }
    }
  }
}

#Preview {
  registerFonts()
  return LayoutView().padding()
}
