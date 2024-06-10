//
//  SwiftUIView.swift
//  
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import SwiftUI

extension View {
    func sectionView() -> some View {
        modifier(SectionView())
    }
}

struct SectionView: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 10).fill(AppTheme.Colors.sectionViewColor)
            )
    }
}
