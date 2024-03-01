//
//  Playbook Swift Design System
//
//  Copyright © 2024 Power Home Remodeling Group
//  This software is distributed under the ISC License
//
//  PBCurrency.swift
//

import SwiftUI

public struct PBCurrency: View {
  let dollarAmount: String?
  let decimalAmount: String?
  let label: String?
  let size: PBFont
  let symbol: String?
  let unit: String?
  let alignment: Alignment
  let isEmphasized: Bool
  let hasUnit: Bool
  public init(
    dollarAmount: String? = nil,
    decimalAmount: String? = nil,
    label: String? = nil,
    size: PBFont = .body,
    symbol: String? = nil,
    unit: String? = nil,
    alignment: Alignment = .leading,
    isEmphasized: Bool = false,
    hasUnit: Bool = false
  ) {
    self.dollarAmount = dollarAmount
    self.decimalAmount = decimalAmount
    self.label = label
    self.size = size
    self.symbol = symbol
    self.unit = unit
    self.alignment = alignment
    self.isEmphasized = isEmphasized
    self.hasUnit = hasUnit
  }
  public var body: some View {
    currencyView
  }
}
public extension PBCurrency {
  var currencyView: some View {
    VStack(alignment: .leading, spacing: Spacing.xSmall) {
      Text(label ?? "")
        .pbFont(.caption, variant: .bold, color: .text(.light))
      HStack(spacing: 0) {
        symbolView
        dollarDecimalView
      }
    }
  }
  var symbolView: some View {
    Text(getCurrency(symbol: symbol ?? ""))
      .pbFont(.body, color: .text(.light))
      .baselineOffset(size == .title4  ? 0 : size == .title1 ? 21 : 9)
  }
  @ViewBuilder
  var dollarDecimalView: some View {
   HStack(spacing: 0) {
     Text(formattedDollar)
       .pbFont(size, variant: .bold)
     Text(formattedDecimal)
       .pbFont(.body, variant: .bold)
       .baselineOffset(size == .title4 ? 0 : size == .title1 ? -16 : -5)
   }
  }
  var formattedDollar: AttributedString {
    return colorAttributedText(dollarAmount ?? "", characterToChange: dollarAmount ?? "", color: fontColor)
  }
  var formattedDecimal: AttributedString {
    return colorAttributedText(hasUnit ? unit ?? "" : decimalAmount ?? "", characterToChange: hasUnit ? unit ?? "" : decimalAmount ?? "", color: .text(.light))
  }
  var fontColor: Color {
    isEmphasized ? .text(.default) : .text(.light)
  }
  func getCurrency(symbol: String) -> String {
    let locale = Locale(identifier: symbol)
    let currencySymbol = locale.currencySymbol!
    return currencySymbol
  }
}
#Preview {
  registerFonts()
  return  CurrencyCatalog()
}
