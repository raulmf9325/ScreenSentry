//
//  HomeView.swift
//  ScreenSentry
//
//  Created by Raul Mena on 5/5/24.
//

import SwiftUI
import AppUI

public struct HomeView: View {
    public init() {}
    
    public var body: some View {
        ZStack {
            AppTheme.Colors.accentColor
                .ignoresSafeArea()
        }
    }
}


#Preview {
    HomeView()
}

