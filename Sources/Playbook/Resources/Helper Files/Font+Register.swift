//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  Font+Register.swift
//

import SwiftUI
import power_fonts

/// This helper must be called in the root of the application
/// code, for example in `applicationDidFinishLaunching`.
public func registerFonts() {
  // Fonts
    FontLoader.registerFonts()
  // Icons
  _ = registerFont(bundle: .module, fontName: "Fontastic", fontExtension: "ttf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Brands-Regular-400", fontExtension: "otf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Duotone-Solid-900", fontExtension: "otf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Pro-Light-300", fontExtension: "otf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Pro-Regular-400", fontExtension: "otf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Pro-Solid-900", fontExtension: "otf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Pro-Thin-100", fontExtension: "otf")
  _ = registerFont(bundle: .module, fontName: "Font Awesome 6 Sharp-Solid-900", fontExtension: "otf")
}

private func registerFont(bundle: Bundle, fontName: String, fontExtension: String) -> Bool {
  guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension) else {
    fatalError("Couldn't find font \(fontName)")
  }

  guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL) else {
    fatalError("Couldn't load data from the font \(fontName)")
  }

  guard let font = CGFont(fontDataProvider) else {
    fatalError("Couldn't create font from data")
  }

  var error: Unmanaged<CFError>?
  let success = CTFontManagerRegisterGraphicsFont(font, &error)
  guard success else { return false }
  return true
}

/// This helps debug which fonts have successfully been copied to the bundle.
public func printRegisteredFonts() {
  #if os(iOS)
    let fontFamilies = UIFont.familyNames.sorted()
    for family in fontFamilies {
      print(family)
      for font in UIFont.fontNames(forFamilyName: family).sorted() {
        print("\t\(font)")
      }
    }
  #elseif os(macOS)
    let fontFamilies = NSFontManager.shared.availableFontFamilies.sorted()
    for family in fontFamilies {
      print(family)
      let familyFonts = NSFontManager.shared.availableMembers(ofFontFamily: family)
      if let fonts = familyFonts {
        for font in fonts {
          print("\t\(font)")
        }
      }
    }
  #endif
}
