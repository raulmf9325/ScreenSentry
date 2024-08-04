//
//  BlockAppsTemplateView.swift
//
//
//  Created by Raul Mena on 8/1/24.
//

import ComposableArchitecture
import SwiftUI

struct BlockAppsTemplateView: View {
    let store: StoreOf<Home>

    var body: some View {
        Section(header:
                    Text("Starter Templates")
            .foregroundStyle(.gray)
            .font(.subheadline)
        ) {
            StartSession(store)
            WorkMode()
            RelaxedMorning()
            AdultContent(store)
        }
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
                           onTap: { store.send(.view(.startBlockingSessionButtonTapped)) })
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
                           onTap: { store.send(.view(.blockAdultContentButtonTapped)) })
    }
}
