//
//  Button+Style.swift
//
//
//  Created by Gavin Huang on 4/26/23.
//

import SwiftUI

extension Button {
  @ViewBuilder
  func customButtonStyle(
    variant: PBButton.Variant,
    shape: PBButton.Shape,
    size: PBButton.Size
  ) -> some View {
    switch shape {
    case .primary:
      self.buttonStyle(
        PBButtonStyle(
          variant: variant,
          size: size
        )
      )
    case .circle:
      self.buttonStyle(
        PBCircleButtonStyle(
          variant: variant,
          size: size
        )
      )
    }
  }
}
