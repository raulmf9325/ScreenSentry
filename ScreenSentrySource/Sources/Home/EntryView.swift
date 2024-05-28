//
//  EntryView.swift
//  ScreenSentry
//
//  Created by Raul Mena on 5/5/24.
//

import SwiftUI
import AppUI

public struct EntryView: View {
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
        .tint(.yellow)
    }
}

#Preview {
    EntryView()
}
