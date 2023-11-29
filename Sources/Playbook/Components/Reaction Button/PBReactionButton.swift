//
//  PBReactionButton.swift
//  
//
//  Created by Rachel Radford on 11/26/23.
//

import SwiftUI

public struct PBReactionButton: View {
  @State private var count: Int = 0
  @State private var isHighlighted: Bool = false
  var icon: String?
  var pbIcon: PBIcon?
  var addReactionIcon: String?
  var variant: Variant?
  let action: (() -> Void)?

  init(
    icon: String? = nil,
    pbIcon: PBIcon? = nil,
    addReactionIcon: String? = "smilePlus",
    variant: Variant? = .reactionButtonEmoji,
    action: (() -> Void)? = {}
  ) {
    self.icon = icon
    self.pbIcon = pbIcon
    self.addReactionIcon = addReactionIcon
    self.variant = variant
    self.action = action
  }

  public var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      reactionButtonView
    }
    .padding(.horizontal, 8)
    .padding(.vertical, 2)
  }
}

extension PBReactionButton {
  enum Variant {
    case reactionButtonEmoji, defaultUserButton, addReactionButton
  }

  var iconVariant: any View {
    switch variant {
    case .reactionButtonEmoji, .defaultUserButton, .addReactionButton: return reactionButtonView
    default:
      break
    }
    return self.iconVariant
  }

  var reactionButtonView: some View {
    return VStack(alignment: .leading, spacing: 10) {
      Button {
        pbHighlightReaction()
      } label: {
        reactionButtonLabelView
      }
    }
  }

  var reactionButtonLabelView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      if icon != nil {
        emojiPlusCountView
      } else if pbIcon != nil {
        defaultUserIcon
      } else {
        addReactionEmojiView
      }
    }
    .background(Capsule(style: .circular).stroke(
      isHighlighted && variant != .defaultUserButton ? Color.pbPrimary : Color.border,
      lineWidth: isHighlighted ? 2.0 : 1.0))
  }

  var emojiPlusCountView: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      emojiView
      countView
    }
    .padding(.vertical, 2)
    .padding(.horizontal, 8)
    .frame(height: 28)
  }

  var emojiView: some View {
    return Text(icon ?? "")
      .padding(.leading, count > 0 ? 0 : 4)
      .pbFont(.body, variant: .light, color: .text(.light))
  }

  var countView: some View {
    return Text(count != 0 && variant == .reactionButtonEmoji ? "\(count)" : "153")
      .pbFont(.caption, variant: .light, color: .text(.light))
  }

  var addReactionEmojiView: some View {
    return Image(addReactionIcon ?? "smilePlus", bundle: .module)
      .resizable()
      .pbFont(.caption, variant: .light, color: .text(.light))
      .frame(width: Spacing.xLarge, height: 28)
  }

  var defaultUserIcon: some View {
    return HStack(alignment: .center, spacing: Spacing.xxSmall) {
      PBIcon(FontAwesome.user)
        .pbFont(.caption, variant: .light, color: .text(.lighter))
        .frame(width: Spacing.xLarge, height: 28)
    }
  }

  func pbHighlightReaction() {
    isHighlighted.toggle()
    if isHighlighted == false {
      count -= 1
    } else {
      count += 1
    }
  }
}

#Preview {
  registerFonts()
  return ReactionButtonCatalog()
}
