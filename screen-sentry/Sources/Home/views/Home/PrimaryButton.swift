//
//  SwiftUIView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
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
