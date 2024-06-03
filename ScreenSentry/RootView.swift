//
//  RootView.swift
//  ScreenSentry
//
//  Created by Raul Mena on 6/2/24.
//

import SwiftUI
import Home
import AppUI

public struct AppTabView: View {
    public init() {}
    
    public var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Images.home
                        .renderingMode(.template)
                }
            
            HomeView()
                .tabItem {
                    Images.home
                        .renderingMode(.template)
                }
        }
        .tint(.white)
    }
}

#Preview {
    AppTabView()
}
