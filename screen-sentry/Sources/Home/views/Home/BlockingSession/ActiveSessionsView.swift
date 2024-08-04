//
//  ActiveSessionsView.swift
//
//
//  Created by Raul Mena on 8/1/24.
//

import ComposableArchitecture
import SwiftUI

struct ActiveSessionsView: View {
    let store: StoreOf<Home>

    var body: some View {
        WithPerceptionTracking {
            Section(header:
                        Text("Active Sessions")
                .foregroundStyle(.gray)
                .font(.subheadline)
            ) {
                if store.isBlockingAdultContent {
                    adultContentView
                }
            }
        }
    }

    var adultContentView: some View {
        WithPerceptionTracking {
            BlockingAdultContentView(onPauseButtonTapped: { store.send(.view(.pauseBlockingAdultContentButtonTapped)) },
                                     onDeleteButtonTapped: { store.send(.view(.deleteBlockingAdultContentButtonTapped)) })
            .onTapGesture {
                store.send(.view(.activeAdultBlockingButtonTapped))
            }
        }
    }
}

#Preview {
    ActiveSessionsView(store:
        Store(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.screenTimeApi.requestAccess = {
                return .approved
            }
            $0.screenTimeApi.isBlockingAdultContent = {
                return true
            }
        } )
}
