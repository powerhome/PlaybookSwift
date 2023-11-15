//
//  OnHover.swift
//
//
//  Created by Gavin Huang on 4/11/23.
//

import SwiftUI

extension View {
  func onHover(disabled: Bool, action: @escaping (Bool) -> Void) -> some View {
    return AnyView(
      self.onHover { hovering in
        action(hovering)
        #if os(macOS)
          switch (hovering, disabled) {
          case (true, false): NSCursor.pointingHand.set()
          case (true, true): NSCursor.operationNotAllowed.set()
          default: NSCursor.arrow.set()
          }
        #endif
      }
    )
  }
}
