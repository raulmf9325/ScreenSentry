//
//  StartBlockingSessionView.swift
//
//
//  Created by Raul Mena on 6/11/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

public struct StartBlockingSessionView: View {
    public init(store: StoreOf<StartBlockingSession>) {
        self.store = store
    }
    
    @Perception.Bindable var store: StoreOf<StartBlockingSession>
    
    public var body: some View {
        WithPerceptionTracking {
            ScrollView {
                VStack(spacing: 30) {
                    Text("Start Blocking Now")
                        .foregroundStyle(.white)
                        .padding(.top)
                    
                    VStack {
                        HStack {
                            Text("Select apps and websites to block")
                                .foregroundStyle(.gray)
                            Spacer()
                            Text("+")
                                .font(.headline)
                                .foregroundStyle(.gray)
                        }
                    }
                    .sectionView()
                }
                .padding()
            }
            .background(AppTheme.Colors.accentColor.ignoresSafeArea())
        }
    }
}

#Preview {
    StartBlockingSessionView(store: Store(initialState: StartBlockingSession.State()) {
        StartBlockingSession()
    } withDependencies: {
        $0.screenTimeApi.requestAccess = { @Sendable in
            return .approved
        }
    } )
}
