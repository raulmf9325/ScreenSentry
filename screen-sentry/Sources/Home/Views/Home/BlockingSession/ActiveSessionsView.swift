//
//  ActiveSessionsView.swift
//
//
//  Created by Raul Mena on 8/1/24.
//

import AdultContent
import ComposableArchitecture
import SwiftUI

struct ActiveSessionsView: View {
    @Perception.Bindable var store: StoreOf<HomeFeature>

    var body: some View {
        WithPerceptionTracking {
            Section(header:
                        Text("Active Sessions")
                .foregroundStyle(.gray)
                .font(.subheadline)
            ) {
                IfLetStore(store.scope(state: \.adultBlockingSession, action: \.adultBlockingSession)) { store in
                    BlockingAdultContentView(store: store)
                }
            }
        }
    }
}

#Preview {
    ActiveSessionsView(store:
        Store(initialState: HomeFeature.State()) {
        HomeFeature()
        } withDependencies: {
            $0.screenTimeApi.requestAccess = {
                return .approved
            }
            $0.screenTimeApi.isBlockingAdultContent = {
                return true
            }
        } )
}
