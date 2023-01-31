//
//  PBMultipleUsersIndicator.swift
//  
//
//  Created by Isis Silva on 30/01/23.
//

import SwiftUI

public struct PBMultipleUsersIndicator: View {
    let usersCount: Int?
    var size: PBAvatar.Size
    
    public var body: some View {
        if let count = usersCount, count != 0 {
            Text("+\(count)")
                .tag("additionalUser")
                .pbFont(.buttonText(size.fontSize), color: .pbPrimary)
                .frame(width: size.diameter)
                .padding(6)
                .frame(width: size.diameter)
                .background(Color.pbShadow)
                .clipShape(Circle())
                .background() {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: size.diameter)
                    
                }
                .overlay {
                    Circle()
                        .strokeBorder(.white, lineWidth: 1)
                        .frame(width: size.diameter)
                }
        }
    }
}
struct PBMultipleUsersIndicator_Previews: PreviewProvider {
    static var previews: some View {
        registerFonts()
        return PBMultipleUsersIndicator(usersCount: 4, size: .small)
    }
}
