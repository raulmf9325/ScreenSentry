//
//  HomeView.swift
//  ScreenSentry
//
//  Created by Raul Mena on 5/5/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI
import ScreenTimeAPI
import StartBlockingSession

public struct HomeView: View {
    @Perception.Bindable var store: StoreOf<Home>
    
    public init(store: StoreOf<Home>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack {
                    if store.screenTimeAccess == .denied {
                        PermissionDeniedView(onButtonTapped: requestScreenTimeAccess)
                        Spacer()
                    } else {
                        BlockContentView(onStartBlockingSessionButtonTapped: {
                            store.send(.onStartBlockingSessionButtonTapped)
                        },
                                         onWorkModeButtonTapped: {},
                                         onRelaxedMorningButtonTapped: {})
                    }
                }
                .padding(10)
            }
            .background(
                AppTheme.Colors.accentColor
                    .ignoresSafeArea()
            )
            .onAppear {
                store.send(.onHomeViewAppeared)
            }
            .sheet(
                item: $store.scope(state: \.startBlockingSession, action: \.startBlockingSession)) { startBlockingSessionStore in
                    StartBlockingSessionView(store: startBlockingSessionStore)
                }
        }
    }
    
    func requestScreenTimeAccess() {
        store.send(.requestScreenTimeApiAccess)
    }
}


#Preview {
    HomeView(store: Store(initialState: Home.State()) {
        Home()
    } withDependencies: {
        $0.screenTimeApi.requestAccess = { @Sendable in
            return .approved
        }
    } )
}

