//
//  PBRadio.swift
//
//
//  Created by mpc on 8/9/21.
//

import SwiftUI

// MARK: - PBRadioItem

public struct PBRadioItem: Identifiable, Equatable {
  public var title: String
  public var subtitle: String
  public var id: String { title }

  public init(_ title: String, subtitle: String = "") {
    self.title = title
    self.subtitle = subtitle
  }
}

public struct PBRadio: View {
  let items: [PBRadioItem]
  let orientation: Orientation
  let alignment: Orientation
  let spacing: CGFloat
  let padding: CGFloat
  let errorState: Bool
  @Binding var selectedItem: PBRadioItem?

  public init(
    items: [PBRadioItem],
    orientation: Orientation = .vertical,
    alignment: Orientation = .horizontal,
    spacing: CGFloat = Spacing.xSmall,
    padding: CGFloat = Spacing.xSmall,
    selected: Binding<PBRadioItem?>,
    errorState: Bool = false
  ) {
    self.items = items
    self.orientation = orientation
    self.alignment = alignment
    self.spacing = spacing
    self.padding = padding
    self.errorState = errorState
    _selectedItem = selected
  }

  public var body: some View {
    switch orientation {
    case .vertical:
      VStack(alignment: .leading, spacing: spacing) {
        ForEach(items) { item in
          Button(item.title) {
            selectedItem = item
          }
          .buttonStyle(
            PBRadioButtonStyle(
              subtitle: item.subtitle,
              isSelected: selectedItem?.id == item.id,
              alignment: alignment,
              padding: padding,
              errorState: errorState
            )
          )
        }
      }

    case .horizontal:
      HStack(spacing: spacing) {
        ForEach(items) { item in
          Button(item.title) {
            selectedItem = item
          }
          .buttonStyle(
            PBRadioButtonStyle(
              subtitle: item.subtitle,
              isSelected: selectedItem?.id == item.id,
              alignment: alignment,
              padding: padding,
              errorState: errorState
            )
          )
        }
      }
    }
  }
}

// MARK: - PBRadioButtonStyle

public struct PBRadioButtonStyle: ButtonStyle {
  private let subtitle: String
  private let isSelected: Bool
  private let alignment: Orientation
  private let padding: CGFloat
  private let errorState: Bool

  private var borderColor: Color {
    isSelected ? .pbPrimary : .border
  }

  private var erroBorderColor: Color {
    isSelected ? .pbPrimary : .red
  }

  private var lineWidth: CGFloat {
    isSelected ? 6 : 2
  }

  public init(
    subtitle: String?,
    isSelected: Bool,
    alignment: Orientation,
    padding: CGFloat,
    errorState: Bool
  ) {
    self.isSelected = isSelected
    self.subtitle = subtitle ?? ""
    self.alignment = alignment
    self.padding = padding
    self.errorState = errorState
  }

  public func makeBody(configuration: Configuration) -> some View {
    switch alignment {
    case .horizontal:
      HStack(alignment: .top, spacing: padding) {
        Circle()
          .strokeBorder(errorState == true ? erroBorderColor : borderColor, lineWidth: lineWidth)
          .frame(width: 22, height: 22)
        VStack(alignment: .leading, spacing: Spacing.xxSmall) {
          configuration.label
            .foregroundColor(errorState == true ? .status(.error) : .text(.default))
            .pbFont(.body())
            .frame(minHeight: 22)
          if !subtitle.isEmpty {
            Text(subtitle)
              .foregroundColor(.text(.light))
              .pbFont(.subcaption)
          }
        }
      }
      .contentShape(Rectangle())
    case .vertical:
      VStack {
        Circle()
          .strokeBorder(errorState == true ? erroBorderColor :  borderColor, lineWidth: lineWidth)
          .frame(width: 22, height: 22)
        VStack(alignment: .leading, spacing: Spacing.xxSmall) {
          configuration.label
            .foregroundColor(errorState == true ? .status(.error) :  .text(.default))
            .pbFont(.body())
            .frame(minHeight: 22)
        }
      }
      .contentShape(Rectangle())
    }

  }
}

// MARK: - Previews

public struct PBRadio_Previews: PreviewProvider {
  public static var previews: some View {
    RadioCatalog()
  }
}
