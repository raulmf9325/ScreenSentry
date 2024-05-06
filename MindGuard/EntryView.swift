//
//  EntryView.swift
//  MindGuard
//
//  Created by Raul Mena on 5/5/24.
//

import SwiftUI

struct EntryView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    AppTheme.Images.home
                        .renderingMode(.template)
                }
            
            HomeView()
                .tabItem {
                    AppTheme.Images.home
                        .renderingMode(.template)
                }
        }
        .tint(.yellow)
    }
}

#Preview {
    EntryView()
}
