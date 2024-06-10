//
//  RootView.swift
//  ScreenSentry
//
//  Created by Raul Mena on 6/2/24.
//

import ComposableArchitecture
import SwiftUI
import Home
import AppUI
import AppCore

public struct AppTabView: View {
    @Perception.Bindable var store: StoreOf<ScreenSentry>
    
    public init(store: StoreOf<ScreenSentry>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            TabView {
                HomeView(store: store.scope(state: \.home, action: \.home))
                    .tabItem {
                        Images.home
                            .renderingMode(.template)
                    }
                
                HomeView(store: store.scope(state: \.profile, action: \.profile))
                    .tabItem {
                        Images.home
                            .renderingMode(.template)
                    }
            }
            .tint(.white)
        }
    }
}

#Preview {
    AppTabView(store: Store(initialState: ScreenSentry.State()) {
        ScreenSentry()
    })
}
