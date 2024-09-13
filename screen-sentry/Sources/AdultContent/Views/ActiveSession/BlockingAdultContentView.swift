//
//  BlockingAdultContentView.swift
//
//
//  Created by Raul Mena on 8/1/24.
//

import ComposableArchitecture
import SwiftUI

public struct BlockingAdultContentView: View {
    public init(store: StoreOf<AdultBlockingSession>) {
        self.store = store
    }
    
    @Perception.Bindable var store: StoreOf<AdultBlockingSession>

    public var body: some View {
        WithPerceptionTracking {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("🔞")
                            .font(.system(size: 30))

                        Text("Blocking Adult Content")
                            .foregroundStyle(.white)
                    }

                    Text(store.timerLabel)
                        .foregroundStyle(.white)
                        .font(.caption)
                        .italic()
                        .monospacedDigit()
                        .padding(.leading, 10)
                }
                Spacer()
                Text("⏳")
            }
            .padding(.vertical, 6)
            .sectionView()
            .listRowBackground(Color.clear)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .swipeActions {
                Button(action: { store.send(.view(.pauseBlockingAdultContentButtonTapped)) }) {
                    Label("Pause", systemImage: "pause.circle.fill")
                }
                .tint(Color.blue)

                Button(action: { store.send(.view(.deleteBlockingAdultContentButtonTapped)) }) {
                    Label("Delete", systemImage: "trash.circle.fill")
                }
                .tint(Color.red)
            }
            .onAppear {
                store.send(.view(.blockingAdultContentViewAppeared))
            }
            .onTapGesture {
                store.send(.view(.blockingAdultContentViewTapped))
            }
            .sheet(item: $store.scope(state: \.destination?.confirmPauseResumeDeleteAdultContent, action: \.destination.confirmPauseResumeDeleteAdultContent)) { _ in
                confirmPauseOrDeleteAdultSession
            }
        }
    }

    var confirmPauseOrDeleteAdultSession: some View {
        WithPerceptionTracking {
            PauseOrEndAdultBlockingSessionView(store: store)

        }
    }
}

#Preview {
    BlockingAdultContentView(store: Store(initialState: AdultBlockingSession.State()) {
        AdultBlockingSession()
    })
}
