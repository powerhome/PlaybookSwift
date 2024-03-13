//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  OnChange+Debounce.swift
//

import SwiftUI

public extension View {
  func onChange<Value>(
    of value: Value,
    debounce: (time: TimeInterval, numberOfCharacters: Int),
    perform action: @escaping (_ newValue: Value?) -> Void
  ) -> some View where Value: Equatable, Value: Collection {
    self.modifier(DebouncedChangeViewModifier(trigger: value, debounce: debounce, action: action))
  }
}

private struct DebouncedChangeViewModifier<Value>: ViewModifier where Value: Equatable, Value: Collection {
  let trigger: Value
  let debounce: (time: TimeInterval, numberOfCharacters: Int)
  let action: (Value?) -> Void
  @State private var debouncedTask: Task<Void,Never>?
  
  func body(content: Content) -> some View {
    if debounce.numberOfCharacters != 0 {
      content.onChange(of: trigger) { oldValue, newValue in
        debouncedTask?.cancel()
        
        if newValue.count >= debounce.numberOfCharacters {
          debouncedTask = Task.delayed(seconds: debounce.time) { @MainActor in
            action(newValue)
          }
        } else if oldValue.count > newValue.count {
          if newValue.count >= debounce.numberOfCharacters {
            action(newValue)
          } else if newValue.count == 0 {
            action(" " as? Value)
          }
        }
      }
    } else {
      content
        .onAppear {
          debouncedTask = Task.delayed(seconds: debounce.time) { @MainActor in
            action(nil)
          }
        }
        .onChange(of: trigger) { value in
          debouncedTask?.cancel()
          debouncedTask = Task.delayed(seconds: debounce.time) { @MainActor in
            action(value)
          }
        }
    }
  }
}

extension Task {
  @discardableResult
  public static func delayed(
    seconds: TimeInterval,
    operation: @escaping @Sendable () async -> Void
  ) -> Self where Success == Void, Failure == Never {
    Self {
      do {
        try await Task<Never, Never>.sleep(nanoseconds: UInt64(seconds * 1e9))
        await operation()
      } catch {}
    }
  }
}
