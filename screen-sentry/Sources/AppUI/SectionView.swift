//
//  SwiftUIView.swift
//  
//
//  Created by Raul Mena on 6/10/24.
//

import SwiftUI

public extension View {
    func sectionView() -> some View {
        modifier(SectionView())
    }
}

struct SectionView: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
                .padding(.vertical)
                .padding(.horizontal, 10)
            Spacer()
        }
        .background(
            RoundedRectangle(cornerRadius: 10).fill(AppTheme.Colors.sectionViewColor)
        )
    }
}
