//
//  PBMessage.swift
//
//
//  Created by Alexandre Hauber on 29/07/21.
//

import SwiftUI

public struct PBMessage<Content: View, Avatar: View>: View {
  let content: Content
  var avatar: Avatar
  let label: String?
  let timestamp: PBTimestamp?

  public init(
    avatar: Avatar,
    label: String? = nil,
    timestamp: PBTimestamp? = nil,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.avatar = avatar
    self.label = label
    self.timestamp = timestamp
  }

  public var body: some View {
    HStack(alignment: .top, spacing: nil) {
      avatar
      VStack(alignment: .leading, spacing: nil) {
        HStack(alignment: .firstTextBaseline, spacing: 2) {
          if let label = label, !label.isEmpty {
            Text(label).pbFont(.title4)
          }
          if let timestamp = timestamp {
            timestamp.padding(.leading, 8)
          }
        }
        content
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, alignment: .topLeading)
  }
}

public struct PBMessage_Previews: PreviewProvider {
  public static var previews: some View {
    registerFonts()

    return PBMessage(
      avatar: PBAvatar(image: Image("andrew", bundle: .module)),
      label: "Andrew Black", timestamp: PBTimestamp(Date(), showDate: false)
    ) {
      Text("This below ir our great friend (and amazing dev), aka me, Andrew:").pbFont(.body())
      Image("andrew", bundle: .module).resizable().frame(width: 240, height: 240)
    }
  }
}
