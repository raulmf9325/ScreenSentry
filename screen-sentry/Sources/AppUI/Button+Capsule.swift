//
//  File.swift
//  
//
//  Created by Raul Mena on 8/4/24.
//

import SwiftUI

public struct CapsuleButtonStyle: ButtonStyle {
    public init(
        textColor: Color = .black,
        backgroundColor: Color = .white) {
            self.textColor = textColor
            self.backgroundColor = backgroundColor
        }

    let textColor: Color
    let backgroundColor: Color

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundStyle(textColor)
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}
