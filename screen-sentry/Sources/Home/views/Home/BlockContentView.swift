//
//  BlockContentView.swift
//
//
//  Created by Raul Mena on 6/10/24.
//

import AdultContent
import AppUI
import ComposableArchitecture
import SwiftUI

struct BlockContentView: View {
    @Perception.Bindable var store: StoreOf<Home>

    var body: some View {
        WithPerceptionTracking {
            List {
                if store.adultBlockingSession != nil {
                    ActiveSessionsView(store: store)
                }
                BlockAppsTemplateView(store: store)
            }
            .scrollContentBackground(.hidden)
            .listStyle(.insetGrouped)
            .sheet(item: $store.scope(state: \.destination?.confirmStartBlockingAdultContent,
                                      action: \.destination.confirmStartBlockingAdultContent)) { store in
                ConfirmStartBlockingAdultContentView(store: store)
                .presentationDetents([.fraction(1/2)])
                .presentationDragIndicator(.visible)
            }
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
