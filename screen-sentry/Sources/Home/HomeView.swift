//
//  HomeView.swift
//  ScreenSentry
//
//  Created by Raul Mena on 5/5/24.
//

import ComposableArchitecture
import SwiftUI
import AppUI

public struct HomeView: View {
    @Perception.Bindable var store: StoreOf<Home>
    
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                AppTheme.Colors.accentColor
                    .ignoresSafeArea()                
            }
        }
    }
}


#Preview {
    HomeView(store: Store(initialState: Home.State()) {
        Home()
    })
}

