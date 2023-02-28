//
//  PBCheckbox.swift
//  
//
//  Created by Everton Cunha on 15/06/22.
//

import SwiftUI

public struct PBCheckboxButtonStyle: ButtonStyle {
    let isSelected: Bool

    private var borderColor: Color {
      isSelected ? .pbPrimary : .border
    }

    var backgroundColor: Color {
      isSelected ? .pbPrimary : .clear
    }

    public init(isSelected: Bool) {
        self.isSelected = isSelected
    }

    public func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .top) {
            ZStack {
                RoundedRectangle(cornerRadius: 4)
                .strokeBorder(borderColor, lineWidth: 2)
                    .background(backgroundColor)
                    .clipShape(RoundedRectangle(cornerRadius: 4))
                    .frame(width: 22, height: 22)
                PBIcon.fontAwesome(.check, size: .small)
                    .foregroundColor(Color.white)
            }
            VStack(alignment: .leading, spacing: 4) {
                configuration.label
                    .foregroundColor(.text(.textDefault))
                    .pbFont(.body())
                    .frame(minHeight: 22)
            }
        }
        .frame(minWidth: 44, minHeight: 44)
        .contentShape(Rectangle())
    }
}

struct PBCheckbox_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()
        return VStack {
            Button("Checkbox example") {}
                .buttonStyle(PBCheckboxButtonStyle(isSelected: false))

            Button("Marked example") {}
                .buttonStyle(PBCheckboxButtonStyle(isSelected: true))
        }
    }
}
