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

    var adultContentView: some View {
        BlockingAdultContentView(onPauseButtonTapped: { store.send(.view(.pauseBlockingAdultContentButtonTapped)) },
                                 onDeleteButtonTapped: { store.send(.view(.deleteBlockingAdultContentButtonTapped)) })
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
