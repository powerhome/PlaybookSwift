//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBUser.swift
//

import SwiftUI

public struct PBUser: View {
  public var name: String
  public var nameFont: Typography
  public var image: Image?
  public var orientation: Orientation = .horizontal
  public var size: Size = .small
  public var territory: String?
  public var title: String?
  public var subtitle: AnyView?
  public var status: PBOnlineStatus.Status?
  public var displayAvatar: Bool = true
  public var territoryTitleFont: PBFont
    public init(
        name: String = "",
        nameFont: Typography = .init(font: .title4, variant: .bold),
        image: Image? = nil,
        orientation: Orientation = .horizontal,
        size: Size = .medium,
        territory: String? = nil,
        title: String? = nil,
        subtitle: AnyView? = nil,
        status: PBOnlineStatus.Status? = nil,
        displayAvatar: Bool = true,
        territoryTitleFont: PBFont = .subcaption
    ) {
        self.name = name
        self.nameFont = nameFont
        self.image = image
        self.orientation = orientation
        self.size = size
        self.territory = territory
        self.title = title
        self.subtitle = subtitle
        self.status = status
        self.displayAvatar = displayAvatar
        self.territoryTitleFont = territoryTitleFont
    }
    
    public var body: some View {
        if orientation == .horizontal {
            horizontalView
        } else {
            verticalView
        }
    }
}

public extension PBUser {
    var horizontalView: some View {
        HStack(spacing: Spacing.small) {
            if displayAvatar {
                avatarView
            }
            contentView
        }
    }
    
    var verticalView: some View {
        VStack(spacing: Spacing.xSmall) {
            if displayAvatar {
                avatarView
            }
            contentView
        }
    }
    
    var alignment: HorizontalAlignment {
        return orientation != .horizontal && displayAvatar ? .center : .leading
    }
    
    var avatarView: some View {
        PBAvatar(image: image, name: name, size: size.avatarSize, status: status)
    }
    
    var contentView: some View {
        VStack(alignment: alignment, spacing: Spacing.none) {
            Text(name)
                .pbFont(nameFont.font, variant: nameFont.variant)
                .foregroundColor(.text(.default))
            bodyText.pbFont(territoryTitleFont, color: .text(.light))
                .lineLimit(1)
                .truncationMode(.tail)
            if let content = subtitle {
                content
            }
        }
    }
    
    var titleStyle: PBFont {
        switch size {
            case .large: return .title3
            default: return .title4
        }
    }
    
    var bodyText: Text? {
        if let territory = territory, !territory.isEmpty, let title = title, !title.isEmpty {
            return Text("\(territory) \u{2022} \(title)")
        } else if let territory = territory, !territory.isEmpty {
            return Text(territory)
        } else if let title = title, !title.isEmpty {
            return Text(title)
        } else {
            return nil
        }
    }
}

public extension PBUser {
    enum Size: CaseIterable {
        case small
        case medium
        case large
        
        var avatarSize: PBAvatar.Size {
            switch self {
                case .small: return .small
                case .medium: return .medium
                case .large: return .large
            }
        }
    }
}

#Preview {
    registerFonts()
    return UserCatalog()
}
