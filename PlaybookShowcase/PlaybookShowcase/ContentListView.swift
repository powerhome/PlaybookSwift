//
//  Playbook Swift Design System
//
//  Copyright © 2022 - 2023 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ContentListView.swift
//

import SwiftUI
import Playbook
#if os(iOS)
import UIKit
#endif

struct ContentListView: View {
  let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
  @State var selectedItem: Int = 0
  @State var checked: Bool = false
#if os(iOS)
  init() {
    let appearance = UINavigationBarAppearance()
    appearance.configureWithOpaqueBackground()
    appearance.backgroundColor = .systemBackground
    appearance.titleTextAttributes = [.foregroundColor: UIColor(Color.text(.default))]
    appearance.backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(Color.pbPrimary)]
    UINavigationBar.appearance().standardAppearance = appearance
    UINavigationBar.appearance().compactAppearance = appearance
    UINavigationBar.appearance().scrollEdgeAppearance = appearance
  }
#endif
  var body: some View {
    NavigationStack {
      contentView.padding(.bottom, 80)
        .toolbar {
          ToolbarItem(placement: .cancellationAction) {
            HStack(alignment: .center, spacing: Spacing.xLarge) {
              HStack(spacing: Spacing.xxSmall) {
                playbookLogo
                if let version = version {
                  PBBadge(text: version, variant: .success)
                }
              }
            }
          }
          ToolbarItem {
           darkmodeToggle
          }
        }
        .background {
          checked ? Color.background(.dark) : Color.background(.light)
        }
        .overlay {
          VStack {
            Spacer()
            bottomBar
          }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    .preferredColorScheme(checked ? .dark : .light)
    #if os(iOS)
    .navigationViewStyle(.stack)
    #endif
  }
}

@available(iOS 16.4, *)
extension ContentListView {
  var bottomBar: some View {
    HStack(alignment: .center) {
      PBNav(
        selected: $selectedItem,
        variant: .subtle,
        orientation: .horizontal
      ) {
        PBNavItem(DesignElements.title)
        PBNavItem(Components.title)
        PBNavItem("Layout")
      }
      .scaledToFit()
      .frame(minHeight: 80)
    }
  }
  @ViewBuilder
  private var contentView: some View {
    if selectedItem == 0 {
      designElementsView
    } else if selectedItem == 1 {
      componentsView
    } else {
      LayoutView()
    }
  }
  private var playbookLogo: some View {
    HStack {
      Image("Playbook")
      Text("Playbook")
        .pbFont(.title4, variant: .link)
    }
  }
  private var componentsView: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
        Text(Components.title).pbFont(.title3)
        VStack(spacing: Spacing.small) {
          ForEach(Components.allCases, id: \.self) { element in
            NavigationLink {
              element.destination
                .toolbar {
                  ToolbarItem {
                    darkmodeToggle
                  }
                }
            } label: {
              PBCard(borderRadius: BorderRadius.large, padding: Spacing.small, shadow: .deep) {
                HStack {
                  Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                    .multilineTextAlignment(.leading)
                  PBIcon.fontAwesome(.chevronRight, size: .small)
                    .foregroundColor(.text(.default))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
              }
            }
            .buttonStyle(.plain)
          }
        }
      }
    }
    .padding()
  }
  private var designElementsView: some View {
    ScrollView(showsIndicators: false) {
      VStack(alignment: .leading) {
        Text(DesignElements.title).pbFont(.title3)
        VStack(spacing: Spacing.small) {
          ForEach(DesignElements.allCases, id: \.self) { element in
            NavigationLink {
              element.destination
                .toolbar {
                  ToolbarItem {
                    darkmodeToggle
                  }
                }
            } label: {
              PBCard(borderRadius: BorderRadius.large, padding: Spacing.small, shadow: .deep) {
                HStack {
                  PBIcon.fontAwesome(element.icon, size: .small).foregroundColor(checked ? .white : .black)
                  Text(element.rawValue.capitalized).pbFont(.buttonText(16))
                    .multilineTextAlignment(.leading)
                  PBIcon.fontAwesome(.chevronRight, size: .small)
                    .foregroundColor(.text(.default))
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
              }
            }
            .buttonStyle(.plain)
          }
        }
      }
    }
    .padding()
  }
  
  private var darkmodeToggle: some View {
    HStack(spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.moon, size: .xSmall)
        .pbFont(.body, color: .text(.lighter))
      PBToggle(checked: $checked)
    }
  }
}

#Preview {
  registerFonts()
  if #available(iOS 16.4, *) {
    return ContentListView()
  } else {
    return EmptyView()
  }
}
