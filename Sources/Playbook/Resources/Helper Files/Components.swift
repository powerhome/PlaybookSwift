//
//  Components.swift
//
//
//  Created by Isis Silva on 16/05/23.
//

import SwiftUI

@available(macOS 13.0, *)
public enum Componenets: String, CaseIterable {
  case avatar
  case badge
  case button
  case card
  case checkbox
  case collapsible
  case dialog
  case iconCircle
  case image
  case label
  case message
  case nav
  case pill
  case progressIndicator
  case radio
  case sectionSeparator
  case select
  case tags
  case textArea
  case textInput
  case timeAndDate
  case toggle
  case user

  public static let title: String = "Components"

  @ViewBuilder
  public var destination: some View {
    switch self {
    case .avatar: AvatarCatalog()
    case .badge: BadgeCatalog()
    case .button: ButtonsCatalog()
    case .card: CardCatalog()
    case .checkbox: CheckboxCatalog()
    case .collapsible: CollapsibleCatalog()
    case .dialog: DialogCatalog()
    case .iconCircle: IconCircleCatalog()
    case .image: PBImage_Previews.previews
    case .label: PBLabelValue_Previews.previews
    case .message: PBMessage_Previews.previews
    case .nav: PBNav_Previews.previews
    case .pill: PillCatalog()
    case .progressIndicator: PBSpinner_Previews.previews
    case .radio: PBRadio_Previews.previews
    case .sectionSeparator: PBSectionSeparator_Previews.previews
    case .select: PBSelect_Previews.previews
    case .tags: PBBadge_Previews.previews
    case .textArea: PBTextArea_Previews.previews
    case .textInput: PBTextInput_Previews.previews
    case .timeAndDate: PBTimestamp_Previews.previews
    case .toggle: PBRadio_Previews.previews
    case .user: PBMultipleUsers_Previews.previews
    }
  }
}
