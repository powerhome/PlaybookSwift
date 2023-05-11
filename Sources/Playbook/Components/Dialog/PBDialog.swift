//
//  PBDialog.swift
//
//
//  Created by Michael Campbell on 7/15/21.
//

import SwiftUI

public struct PBDialog<Content: View>: View {
  @Environment(\.presentationMode) var presentationMode
  let content: Content?
  let title: String?
  let message: String?
  let variant: DialogVariant
  let isStacked: Bool
  let cancelButton: (String, (() -> Void)?)?
  let confirmButton: (String, (() -> Void))?
  let onClose: (() -> Void)?
  let size: DialogSize
  let shouldCloseOnOverlay: Bool

  public init(
    title: String? = nil,
    message: String? = nil,
    variant: DialogVariant = .default,
    isStacked: Bool = false,
    cancelButton: (String, (() -> Void)?)? = nil,
    confirmButton: (String, (() -> Void))? = nil,
    onClose: (() -> Void)? = nil,
    size: DialogSize = .medium,
    shouldCloseOnOverlay: Bool = true,
    @ViewBuilder content: (() -> Content) = { EmptyView() }
  ) {
    self.content = content()
    self.title = title
    self.message = message
    self.variant = variant
    self.isStacked = isStacked
    self.cancelButton = cancelButton
    self.confirmButton = confirmButton
    self.onClose = onClose
    self.size = size
    self.shouldCloseOnOverlay = shouldCloseOnOverlay
  }

  public var body: some View {
    dialogView()
      .frame(maxWidth: variant.width(size))
      .padding(padding)
      .onTapGesture {
        if shouldCloseOnOverlay {
          if let onClose = onClose {
            onClose()
          } else {
            dismissDialog()
          }
        }
      }
  }

  private func dialogView() -> some View {
    return PBCard(alignment: .center, padding: .pbNone) {
      switch variant {
      case .default:
        if let title = title {
          PBDialogHeaderView(title: title) { dismissDialog() }
          PBSectionSeparator()
        }

        if let message = message {
          Text(message)
            .pbFont(.body())
            .padding()
        }

        content

      case .status(let status):
        PBStatusDialogView(status: status, title: title ?? "", description: message ?? "")
      }

      if let confirmButton = confirmButton {
        PBDialogActionView(
          isStacked: isStacked,
          confirmButton: confirmButton,
          cancelButton: cancelButtonAction(),
          variant: variant
        )
        .padding()
      }
    }
    .frame(width: variant.width(size))
  }

  func cancelButtonAction() -> (String, (() -> Void))? {
    if let cancelButton = cancelButton {
      if let cancelButtonAction = cancelButton.1 {
        return (cancelButton.0, cancelButtonAction)
      } else {
        return (cancelButton.0, { dismissDialog() })
      }
    } else {
      return nil
    }
  }

  var padding: EdgeInsets {
  #if os(macOS)
    return EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
  #elseif os(iOS)
    return EdgeInsets(top: 0, leading: 24, bottom: 0, trailing: 24)
  #endif
  }

  func dismissDialog() {
    presentationMode.wrappedValue.dismiss()
  }
}

public enum DialogSize: String, CaseIterable {
  case small
  case medium
  case large

  var width: CGFloat {
    #if os(macOS)
    switch self {
    case .small: return 300
    case .medium: return 500
    case .large: return 800
    }
    #elseif os(iOS)
    return 300
    #endif
  }
}

public enum DialogVariant: Equatable {
  case `default`
  case status(_ status: DialogStatus)

  public func width(_ size: DialogSize) -> CGFloat {
    switch self {
    case .default: return size.width
    default: return 375
    }
  }
}

struct PBBDialog_Previews: PreviewProvider {
  static var previews: some View {
    registerFonts()

    let infoMessage = "This is a message for informational purposes only and requires no action."

    func foo() {
      print("Hello world!")
    }

    return Group {
      PBDialog(
        title: "This is some informative text",
        message: infoMessage,
        cancelButton: ("Cancel", foo),
        confirmButton: ("Okay", foo)
      )
      .backgroundViewModifier(alpha: 0.2)
      .previewDisplayName("Simple")

      PBDialog(
        title: "Header",
        cancelButton: ("Back", foo),
        confirmButton: ("Send My Issue", foo),
        content: ({
          ScrollView {
            Text("Hello Complex Dialog!\nAnything can be placed here.")
              .pbFont(.title2)
              .multilineTextAlignment(.leading)

            TextField("", text: .constant("text"))
              .textFieldStyle(PBTextInputStyle("Default"))
              .padding()
          }
          .padding()
        }))
      .backgroundViewModifier(alpha: 0.2)
      .previewDisplayName("Complex")

      List(DialogSize.allCases, id: \.self) { size in
        PBDialog(
          title: "\(size.rawValue.capitalized) Dialog",
          message: infoMessage,
          cancelButton: ("Cancel", foo),
          confirmButton: ("Okay", foo),
          size: size
        )
        .backgroundViewModifier(alpha: 0.2)
      }
      .previewDisplayName("Size")

      List {
        Section("Stacked") {
          ScrollView(showsIndicators: false) {
            PBDialog(
              title: "Success!",
              message: infoMessage,
              variant: .status(.success),
              isStacked: true,
              cancelButton: ("Cancel", foo),
              confirmButton: ("Okay", foo),
              size: .small
            )

            PBDialog(
              title: "Error!",
              message: infoMessage,
              variant: .status(.error),
              isStacked: true,
              confirmButton: ("Okay", foo),
              size: .small
            )
          }
          .frame(maxWidth: .infinity)
          .backgroundViewModifier(alpha: 0.2)
        }

        Section("Default") {
          PBDialog(
            title: "Caution!",
            message: infoMessage,
            variant: .status(.caution),
            isStacked: false,
            cancelButton: ("Cancel", foo),
            confirmButton: ("Okay", foo),
            size: .small
          )
          .backgroundViewModifier(alpha: 0.2)
          .frame(maxWidth: .infinity)
        }
      }
      .previewDisplayName("Stacked")

      List(DialogStatus.allCases, id: \.self) { status in
        Section(status.rawValue) {
          PBDialog(
            title: status.rawValue.capitalized,
            message: infoMessage,
            variant: .status(status),
            isStacked: false,
            cancelButton: ("Cancel", foo),
            confirmButton: ("Okay", foo)
          )
          .frame(maxWidth: .infinity)
          .backgroundViewModifier(alpha: 0.2)
        }
      }
      .previewDisplayName("Status")
    }
  }
}
