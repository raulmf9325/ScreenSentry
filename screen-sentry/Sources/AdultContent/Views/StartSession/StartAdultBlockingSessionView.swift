//
//  ConfirmStartBlockingAdultContentView.swift
//
//
//  Created by Raul Mena on 8/4/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

public struct StartAdultBlockingSessionView: View {
    public init(store: StoreOf<StartAdultBlockingSession>) {
        self.store = store
    }
    
    @Perception.Bindable var store: StoreOf<StartAdultBlockingSession>

    @Environment(\.dismiss) private var dismiss

    public var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("Adult Websites Will Be Blocked On All Browsers")
                    .font(.title3)
                    .foregroundStyle(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                    .padding(.horizontal)

                Text("Take your first step towards success by desexualizing your brain.")
                    .font(.system(size: 14))
                    .foregroundStyle(Color.gray)
                    .padding(.top, 5)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                SegmentedControl(selectedIndex: $store.durationOptionIndex,
                                 titles: ["Permanently", "Set Duration"])
                .padding(.top, 20)

                if store.durationOption == .permanently {
                    Text("Adult content will be blocked for all major porn sites on all browsers. Content can be unblocked by pausing or deleting this session.")
                        .font(.system(size: 14))
                        .foregroundStyle(Color.gray)
                        .padding(.horizontal)
                        .padding(.top, 30)
                } else {
                    VStack(spacing: 25) {
                        duration
                            .padding(.top, 30)

                        notificationsToggle
                    }
                    .padding(.horizontal)
                }

                Spacer()
                Button("Start") {
                    store.send(.view(.startBlockingAdultSessionButtonTapped))
                }
                .buttonStyle(CapsuleButtonStyle())
                .padding(.horizontal)
            }
            .padding(20)
            .background(AppTheme.Colors.sectionViewColor)
            .sheet(item: $store.scope(state: \.destination?.durationPicker,
                                      action: \.destination.durationPicker)) { _ in
                AdultDurationPicker(store: store)
                    .presentationDetents([.fraction(1/2)])
                    .presentationDragIndicator(.visible)
            }
        }
    }

    var duration: some View {
        let durationText = switch store.selectedTimeUnit {
        case .days: "\(store.selectedNumber) days"
        case .minutes: "\(store.selectedNumber) mins"
        case .hours: "\(store.selectedNumber) hrs"
        }

        return WithPerceptionTracking {
            Button(action: { store.send(.view(.setDurationButtonTapped)) }) {
                HStack {
                    Text("Duration")
                    Spacer()
                    Text(durationText)
                    Image(systemName: "chevron.right")
                        .font(.caption)
                        .bold()
                }
                .foregroundStyle(.white)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .strokeBorder(Color.gray.opacity(0.5), lineWidth: 1)
                        .background(AppTheme.Colors.accentColor)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                )
            }
            .buttonStyle(.plain)
        }
    }

    var notificationsToggle: some View {
        Toggle(isOn: .constant(true), label: {
            Text("Notifications")
                .foregroundStyle(.white)
        })
        .tint(.green)
        .padding(.horizontal)
    }
}

#Preview {
    struct PresentingView: View {
        @State private var isShowingConfirmation = true
        var body: some View {
            AppTheme.Colors.accentColor
                .sheet(isPresented: $isShowingConfirmation) {
                    StartAdultBlockingSessionView(store: Store(initialState: StartAdultBlockingSession.State(durationOption: .setDuration)) {
                        StartAdultBlockingSession()
                    })
                    .presentationDetents([.fraction(0.65)])
                    .presentationDragIndicator(.visible)
                }
        }
    }
    return PresentingView()
}
