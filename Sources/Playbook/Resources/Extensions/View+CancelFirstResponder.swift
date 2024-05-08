//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  View+CancelFirstResponder.swift
//

import SwiftUI

//struct CancelFirstResponder: ViewModifier {
//  let action: (() -> Void)
//
//  func body(content: Content) -> some View {
//    content
//      .onTapGesture {
//        action()
//        #if os(iOS)
//        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//        #elseif os(macOS)
//        NSEvent.addLocalMonitorForEvents(matching: .leftMouseUp) { event in
//          event.window?.makeFirstResponder(nil)
//          event.window?.makeFirstResponder(event.window)
//          return event
//        }
//        #endif
//        }
//  }
//}
//
//public extension View {
//  func cancelFirstResponder(action: @escaping (() -> Void)) -> some View {
//    self.modifier(CancelFirstResponder(action: action))
//  }
//}
