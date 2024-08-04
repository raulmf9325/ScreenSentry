//
//  BlockContentView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

struct BlockContentView: View {
    let store: StoreOf<Home>

    var body: some View {
        WithPerceptionTracking {
            List {
                if store.isBlockingAdultContent {
                    ActiveSessionsView(store: store)
                        .transition(.move(edge: .leading))
                }
                BlockAppsTemplateView(store: store)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
        }
    }
}

#Preview {
    BlockContentView(store:
        Store(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.screenTimeApi.requestAccess = {
                return .approved
            }
        } )
}
