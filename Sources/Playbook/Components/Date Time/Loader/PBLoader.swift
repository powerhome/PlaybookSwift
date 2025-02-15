//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBLoader.swift
//

import SwiftUI

public struct PBLoader: View {
  @State private var dotIndex: Int
  @State private var isAnimating: Bool = false
  let dotsCount: Int
  let dotSize: CGFloat
  let spinnerSpeed: TimeInterval
  let variant: Variant?
  let solidLoaderSize: CGFloat
  let color: Color
  let text: String?
  
  public init(
    dotIndex: Int = 0,
    dotsCount: Int = 8,
    dotSize: CGFloat = 2,
    variant: Variant? = .default,
    solidLoaderSize: CGFloat = 15,
    spinnerSpeed: TimeInterval = 0.1,
    color: Color = .text(.light),
    text: String? = nil
  ) {
    self.dotIndex = dotIndex
    self.dotsCount = dotsCount
    self.dotSize = dotSize
    self.variant = variant
    self.solidLoaderSize = solidLoaderSize
    self.spinnerSpeed = spinnerSpeed
    self.color = color
    self.text = text
  }
  
  public var body: some View {
    HStack {
      loaderVariantView
      if let text = text {
        Text(text).pbFont(.body, color: color)
      }
    }
  }
}

extension PBLoader {
  var loaderView: some View {
    CircularLayout {
      ForEach(0..<dotsCount, id: \.self) { index in
        dotView(index)
      }
    }
    .animation(
      .linear(duration: 5)
      .repeatForever(autoreverses: false),
      value: 360
    )
    .onAppear {
      Timer.scheduledTimer(
        withTimeInterval: spinnerSpeed,
        repeats: true) { _ in
          dotIndex = (dotIndex + 1) % dotsCount
        }
    }
  }
}

extension PBLoader {
  @ViewBuilder
  var loaderVariantView: some View {
    switch variant {
      case .default, .none:
      loaderSpinnerView
    case .solid:
      solidLoaderView
    }
  }
  
  var loaderSpinnerView: some View {
    CircularLayout {
      ForEach(0..<dotsCount, id: \.self) { index in
        dotView(index)
      }
    }
    .animation(
      .linear(duration: 5)
      .repeatForever(autoreverses: false),
      value: 360
    )
    .onAppear {
      Timer.scheduledTimer(
        withTimeInterval: spinnerSpeed,
        repeats: true) { _ in
          dotIndex = (dotIndex + 1) % dotsCount
        }
    }
  }
  
  var solidLoaderView: some View {
    Circle()
      .trim(from: 0, to: 0.8)
      .stroke(color, lineWidth: 2)
      .rotationEffect(.degrees(isAnimating ? 360 : 0))
      .frame(width: solidLoaderSize, height: solidLoaderSize)
      .animation(
        .linear(duration: 0.8)
        .repeatForever(autoreverses: false),
        value: isAnimating
      )
      .onAppear {
        DispatchQueue.main.async {
          isAnimating = true
        }
      }
  }
  
  func dotView(_ index: Int) -> some View {
    Circle()
      .foregroundStyle(dotColor(index))
      .frame(width: dotSize, height: dotSize)
  }
  
  func dotColor(_ index: Int) -> Color {
    index == dotIndex ? Color.clear : color
  }
}

public extension PBLoader {
  enum Variant {
    case `default`, solid
  }
}

#Preview {
  registerFonts()
  return LoaderCatalog()
}
