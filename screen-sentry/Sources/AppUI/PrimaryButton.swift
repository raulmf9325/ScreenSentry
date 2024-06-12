//
//  SwiftUIView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import SwiftUI

public struct PrimaryButton: ButtonStyle {
    public init() {}
    
    public func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .foregroundStyle(AppTheme.Colors.accentColor)
            Spacer()
        }
        .padding()
        .background(AppTheme.Colors.primaryButtonColor)
        .foregroundStyle(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
