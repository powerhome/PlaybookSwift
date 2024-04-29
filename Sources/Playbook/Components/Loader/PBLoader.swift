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
    let dotsCount: Int
    let dotSize: CGFloat
    let spinnerSpeed: TimeInterval
    let variant: PBButton.Variant
    let loaderColor: Color
    public init(
        dotIndex: Int = 0,
        dotsCount: Int = 8,
        dotSize: CGFloat = 2,
        spinnerSpeed: TimeInterval = 0.1,
        variant: PBButton.Variant = .link,
        loaderColor: Color = .text(.light)
    ) {
        self.dotIndex = dotIndex
        self.dotsCount = dotsCount
        self.dotSize = dotSize
        self.spinnerSpeed = spinnerSpeed
        self.variant = variant
        self.loaderColor = loaderColor
    }
   public var body: some View {
        loaderView
    }
}

public extension PBLoader {
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
    func dotView(_ index: Int) -> some View {
        Circle()
            .foregroundStyle(dotColor(index))
            .frame(width: dotSize, height: dotSize)
    }
    func dotColor(_ index: Int) -> Color {
        index == dotIndex ? Color.clear : loaderColor
    }
}

#Preview {
    registerFonts()
    return LoaderCatalog()
}
