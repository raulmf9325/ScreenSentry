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

    init(_ store: StoreOf<Home>) {
        self.store = store
    }

    var body: some View {
        List {
            Section {
                StartSession(store)
                    .swipeActions {
                        Button(action: {}) {
                            Label("Read", systemImage: "envelope.badge.fill")
                        }
                        .tint(Color.red)
                    }
                WorkMode()
                RelaxedMorning()
                AdultContent(store)
            }
        }
        .scrollContentBackground(.hidden)
        .listStyle(.insetGrouped)
    }
}

private struct StartSession: View {
    let store: StoreOf<Home>

    init(_ store: StoreOf<Home>) {
        self.store = store
    }

    var body: some View {
        ContentSectionView(imageName: "lock.app.dashed",
                           imageColor: .blue,
                           imageFont: .title2,
                           title: "Start Blocking Session",
                           description: "Start blocking apps and websites for a selected amount of time.",
                           onTap: { store.send(.onStartBlockingSessionButtonTapped) })
    }
}

private struct WorkMode: View {
    var body: some View {
        ContentSectionView(imageName: "desktopcomputer",
                           imageColor: .green,
                           imageFont: .headline,
                           title: "Work Mode",
                           description: "Block distracting apps and websites so that you can focus on deep work.",
                           onTap: {})
    }
}

private struct RelaxedMorning: View {
    var body: some View {
        ContentSectionView(imageName: "sun.max.fill",
                           imageColor: .orange,
                           imageFont: .headline,
                           title: "Relaxed Morning",
                           description: "Block content every morning until 10 am.",
                           onTap: {})
    }
}

private struct AdultContent: View {
    let store: StoreOf<Home>

    init(_ store: StoreOf<Home>) {
        self.store = store
    }

    var body: some View {
        ContentSectionView(imageName: "18.circle",
                           imageColor: .red,
                           imageFont: .title3,
                           title: "Block Adult Content",
                           description: "Block porn websites to regain focus and mental clarity",
                           onTap: { store.send(.onBlockAdultContentTapped) })
    }
}

#Preview {
    BlockContentView(
        Store(initialState: Home.State()) {
            Home()
        } withDependencies: {
            $0.screenTimeApi.requestAccess = {
                return .approved
            }
        } )
}
