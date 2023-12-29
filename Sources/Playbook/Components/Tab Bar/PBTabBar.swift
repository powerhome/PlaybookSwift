//
//  PBTabBar.swift
//  
//
//  Created by Rachel Radford on 12/15/23.
//

import SwiftUI

public struct PBTabBar: View {
  @State var isTabSelected: Bool
  let variant: Variant
  
  public init(
    isTabSelected: Bool = false,
    variant: Variant = .home
  ) {
    self.isTabSelected = isTabSelected
    self.variant = variant
  }
  
  public var body: some View {
    tabButtonView
  }
}

public extension PBTabBar {
  enum Variant {
    case home, calendar, notifications, search, more
  }
  var tabButtonView: some View {
    return Button {
      isTabSelected.toggle()
    } label: {
      tabButtonLabelView
    }
    .buttonStyle(.plain)
    .pbFont(.subcaption, color: tabIconColor)
    .padding(.bottom, Spacing.large)
    .padding(.leading, -40)
  }
  var tabButtonLabelView: some View {
    return GeometryReader { geo in
      VStack(spacing: Spacing.xxSmall) {
        tabIconView
        tabIconNameView
      }
      .frame(width: geo.size.width / 0.75)
    }
  }
  var tabIconView: PBIcon {
    switch variant {
    case .home: return PBIcon(FontAwesome.home, size: .large)
    case .calendar: return PBIcon(FontAwesome.calendar, size: .large)
    case .notifications: return PBIcon(FontAwesome.bell, size: .large)
    case .search: return PBIcon(FontAwesome.search, size: .large)
    case .more: return PBIcon(FontAwesome.ellipsisH, size: .large)
    }
  }
  var tabIconNameView: Text {
    switch variant {
    case .home: return Text("Home")
    case .calendar: return Text("Calendar")
    case .notifications: return Text("Notifications")
    case .search: return Text("Search")
    case .more: return Text("More")
    }
  }
  var tabIconColor: Color {
    return isTabSelected == true ? Color.pbPrimary : Color.text(.light)
  }
}

#Preview {
  registerFonts()
  return TabBarCatalog()
}
