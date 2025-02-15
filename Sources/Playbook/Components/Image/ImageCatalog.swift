//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  ImageCatalog.swift
//

import SwiftUI

public struct ImageCatalog: View {
  public var body: some View {
    PBDocStack(title: "Image") {
      PBDoc(title: "Default") {
        defaultView
      }
      PBDoc(title: "Rounded") {
        roundedImageView
      }
      PBDoc(title: "GreyScale") {
        greyScaleView
      }
    }
  }
}

extension ImageCatalog {
  var defaultView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
        VStack(alignment: .leading) {
          Text(size.name).pbFont(.detail(true), color: .text(.default))
          PBImage(
            image: nil,
            placeholder: Image("Forest", bundle: .module),
            size: size,
            rounded: .sharp
          )
        }
      }
      VStack(alignment: .leading) {
        Text("None").pbFont(.detail(true), color: .text(.default))
        PBImage(image: Image("Forest", bundle: .module))
      }
    }
  }

  var roundedImageView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
        VStack(alignment: .leading) {
          Text(size.name).pbFont(.detail(true), color: .text(.default))
          PBImage(
            image: nil,
            placeholder: Image("Forest", bundle: .module),
            size: size,
            rounded: .rounded
          )
        }
      }
    }
  }

  var greyScaleView: some View {
    VStack(alignment: .leading, spacing: Spacing.small) {
      ForEach(PBImage.Size.allCases, id: \.rawValue) { size in
        VStack(alignment: .leading) {
          Text(size.name).pbFont(.detail(true), color: .text(.default))
          PBImage(
            image: nil,
            placeholder: Image("Forest", bundle: .module),
            size: size,
            rounded: .rounded,
            isActive: false
          )
        }
      }
    }
  }
}
