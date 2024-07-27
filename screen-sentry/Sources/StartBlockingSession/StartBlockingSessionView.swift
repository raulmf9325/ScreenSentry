//
//  StartBlockingSessionView.swift
//
//
//  Created by Raul Mena on 6/11/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI
import FamilyControls

@ViewAction(for: StartBlockingSession.self)
public struct StartBlockingSessionView: View {
    public init(store: StoreOf<StartBlockingSession>) {
        self.store = store
    }
    
    @Perception.Bindable public var store: StoreOf<StartBlockingSession>
    
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
                        HStack {
                            ForEach(Array(store.activitySelection.applicationTokens), id: \.hashValue) {
                                Label($0)
                            }
                        }
                    }
                    .sectionView()
                    .onTapGesture {
                        send(.onSelectAppsButtonTapped)
                    }
                }
                .padding()
            }
            .background(AppTheme.Colors.accentColor.ignoresSafeArea())
            .familyActivityPicker(isPresented: $store.isShowingActivityPicker,
                                  selection: $store.activitySelection)
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
