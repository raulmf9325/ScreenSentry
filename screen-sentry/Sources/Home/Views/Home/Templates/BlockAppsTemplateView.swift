//
//  BlockAppsTemplateView.swift
//
//
//  Created by Raul Mena on 8/1/24.
//

import ComposableArchitecture
import SwiftUI

struct BlockAppsTemplateView: View {
    let store: StoreOf<HomeFeature>

    var body: some View {
        WithPerceptionTracking {
            Section(header:
                        Text("Starter Templates")
                .foregroundStyle(.gray)
                .font(.subheadline)
            ) {
                StartSession(store)
                WorkMode()
                RelaxedMorning()
                
                if store.adultBlockingSession == nil {
                    AdultContent(store)
                }
            }
        }
    }
}

private struct StartSession: View {
    let store: StoreOf<HomeFeature>

    init(_ store: StoreOf<HomeFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            ContentSectionView(emoji: "⏱️",
                               imageColor: .blue,
                               imageFont: .title2,
                               title: "Start Blocking Session",
                               description: "Start blocking apps and websites for a selected amount of time.",
                               onTap: { store.send(.view(.startBlockingSessionButtonTapped)) })
        }
    }
}

private struct WorkMode: View {
    var body: some View {
        WithPerceptionTracking {
            ContentSectionView(emoji: "💻",
                               imageColor: .green,
                               imageFont: .headline,
                               title: "Work Mode",
                               description: "Block distracting apps and websites so that you can focus on deep work.",
                               onTap: {})
        }
    }
}

private struct RelaxedMorning: View {
    var body: some View {
        WithPerceptionTracking {
            ContentSectionView(emoji: "🌞",
                               imageColor: .orange,
                               imageFont: .headline,
                               title: "Relaxed Morning",
                               description: "Block content every morning until 10 am.",
                               onTap: {})
        }
    }
}

private struct AdultContent: View {
    let store: StoreOf<HomeFeature>

    init(_ store: StoreOf<HomeFeature>) {
        self.store = store
    }

    var body: some View {
        WithPerceptionTracking {
            ContentSectionView(emoji: "🔞",
                               imageColor: .red,
                               imageFont: .title3,
                               title: "Block Adult Content",
                               description: "Block porn websites to regain focus and mental clarity",
                               onTap: { store.send(.view(.templateAdultContentButtonTapped)) })
        }
    }
}
