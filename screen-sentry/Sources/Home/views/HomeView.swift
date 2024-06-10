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
                
                VStack {
                    if store.screenTimeAccess == .denied {
                        ErrorView()
                    }
                }
                .padding(10)
            }
        }
        .onAppear {
            store.send(.onHomeViewAppeared)
        }
    }
    
    func ErrorView() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.title)
                
                Text("Permission denied")
                    .font(.headline)
            }
            .foregroundStyle(.red)
            
            Text("Screen Sentry needs access to Screen Time in order to work.")
                .foregroundStyle(.white)
            
            Button(action: {}) {
                Text("Grant access >")
                    .bold()
                    .foregroundStyle(AppTheme.Colors.primaryTextColor)
            }
        }
        .sectionView()
    }
}


#Preview {
    HomeView(store: Store(initialState: Home.State()) {
        Home()
    })
}

