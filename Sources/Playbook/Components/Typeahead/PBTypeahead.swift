//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBTypeahead.swift
//

import SwiftUI

@available(iOS 17.0, *)
@available(macOS 14.0, *)
public struct PBTypeahead<Content: View>: View {
  typealias Option = (String, Content?)
  private let title: String
  private let placeholder: String
  private let options: [Option]
  private let selection: Selection
  private let clearAction: (() -> Void)?
  @State private var listOptions: [Option] = []
  @State private var showList: Bool = false
  @State private var hoveringIndex: Int = 0
  @State private var hoveringOption: Option?
  @State private var selectedIndex: Int?
  @State private var selectedOptions: [Option] = []
  @State private var focused: Bool = false
  @Binding var searchText: String
  @FocusState private var isFocused

  public init(
    title: String,
    placeholder: String = "Select",
    searchText: Binding<String>,
    selection: Selection,
    options: [(String, Content?)],
    clearAction: (() -> Void)? = nil
  ) {
    self.title = title
    self.placeholder = placeholder
    self._searchText = searchText
    self.selection = selection
    self.options = options
    self.clearAction = clearAction
  }
  
  public var body: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text(title).pbFont(.caption)
        .padding(.bottom, Spacing.xxSmall)
      WrappedInputField(
        placeholder: placeholder,
        searchText: $searchText,
        selection: optionsSelected,
        isFocused: $isFocused,
        clearAction: { clearText },
        onItemTap: { removeSelected($0) },
        onViewTap: { showList.toggle() }
      )
      listView
    }
    .onAppear {
      focused = isFocused
      listOptions = options
      showList = isFocused
      setKeyboardControls
    }
    .onChange(of: isFocused) {
      showList = $1
    }
    .onChange(of: hoveringIndex) {
      print("index: \($0)")
    }
  }
}

@available(iOS 17.0, *)
@available(macOS 14.0, *)
private extension PBTypeahead {
  @ViewBuilder
  var listView: some View {
    if showList {
      PBCard(alignment: .leading, padding: Spacing.none, shadow: .deeper) {
        ScrollView {
          VStack(spacing: 0) {
            ForEach(Array(zip(searchResults.indices, searchResults)), id: \.0) { index, result in
              HStack {
                if let customView = result.1 {
                  customView
                } else {
                  Text(result.0)
                    .pbFont(.body, color: listTextolor(index))
                }
                Spacer()
              }
              .padding(.horizontal, Spacing.xSmall + 4)
              .padding(.vertical, Spacing.xSmall + 4)
              .frame(maxWidth: .infinity, alignment: .leading)
              .background(listBackgroundColor(index))
              .onHover { _ in
                hoveringIndex = index
                hoveringOption = result
              }
              .onTapGesture {
                onListSelection(index: index, option: result)
              }
            }
          }
        }
      }
    }
  }
  
  var searchResults: [Option] {
    switch selection{
    case .multiple:
      return searchText.isEmpty ? listOptions : listOptions.filter {
        $0.0.localizedCaseInsensitiveContains(searchText)
      }
    case .single:
      return searchText.isEmpty ? options : options.filter {
        $0.0.localizedCaseInsensitiveContains(searchText)
      }
    }
  
  }
  
  func listBackgroundColor(_ index: Int?) -> Color {
    switch selection {
    case .single:
      if selectedIndex != nil, selectedIndex == index {
        return .pbPrimary
      }
    default: break
    }
    #if os(macOS)
    return hoveringIndex == index ? .hover : .card
    #elseif os(iOS)
    return .card
    #endif
  }
  
  func listTextolor(_ index: Int?) -> Color {
    if selectedIndex != nil, selectedIndex == index {
      return .white
    } else {
      return .text(.default)
    }
  }

  var optionsSelected: WrappedInputField.Selection {
    let optionsSelected = selectedOptions.map { $0.0 }
    return selection.selectedOptions(options: optionsSelected, placeholder: placeholder)
  }

  func onListSelection(index: Int, option: Option) {
    if showList {
      switch selection {
      case .single:
        onSingleSelection(index: index, option)
      case .multiple:
        onMultipleSelection(option)
      }
    }
    showList = false
    searchText = ""
    hoveringIndex = 0
  }
  
  func onSingleSelection(index: Int, _ option: Option) {
    selectedOptions.removeAll()
    selectedOptions.append(option)
    selectedIndex = index
  }
  
  func onMultipleSelection(_ option: Option) {
    selectedOptions.append(option)
    listOptions.removeAll(where: { $0.0 == option.0 })
  }

  var clearText: Void {
    if let action = clearAction {
      action()
    } else {
      searchText = ""
      listOptions.append(contentsOf: selectedOptions)
      selectedOptions.removeAll()
      showList = false
    }
  }
  
  func removeSelected(_ index: Int) {
    if let selectedElementIndex = selectedOptions.indices.first(where: { $0 == index }) {
      let selectedElement = selectedOptions.remove(at: selectedElementIndex)
      listOptions.append(selectedElement)
    }
  }

  var setKeyboardControls: Void {
    #if os(macOS)
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { event in
      if event.keyCode == 48  { // tab
        focused = true
      }
      if event.keyCode == 49 || event.keyCode == 36 { // space & return bar
        if hoveringIndex <= listOptions.count-1, isFocused {
          onListSelection(index: hoveringIndex, option: listOptions[hoveringIndex])
          hoveringIndex = 0
        }
      }
      if event.keyCode == 51 { // delete
        if let lastElementIndex = selectedOptions.indices.last, isFocused {
          removeSelected(lastElementIndex)
        }
      }
      if event.keyCode == 125 { // arrow down
        if isFocused {
          hoveringIndex = hoveringIndex < searchResults.count ? (hoveringIndex + 1) : 0
        }
      }
      else {
        if event.keyCode == 126 { // arrow up
          if isFocused {
            hoveringIndex = hoveringIndex > 1 ? (hoveringIndex - 1) : 0
          }
        }
      }
      return event
    }
    #endif
  }
}

@available(iOS 17.0, *)
@available(macOS 14.0, *)
public extension PBTypeahead {
  enum Selection {
    case single, multiple(variant: WrappedInputField.Selection.Variant)

    func selectedOptions(options: [String], placeholder: String) -> WrappedInputField.Selection {
      switch self {
      case .single: return .single(options.first)
      case .multiple(let variant): return .multiple(variant, options)
      }
    }
  }
}

#Preview {
  registerFonts()
  if #available(iOS 17.0, *), #available(macOS 14.0, *) {
    return TypeaheadCatalog()
  } else {
    return EmptyView()
  }
}
