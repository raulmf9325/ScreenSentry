//
//  AdultDurationPicker.swift
//
//
//  Created by Raul Mena on 8/8/24.
//

import AppUI
import ComposableArchitecture
import SwiftUI

public enum TimeUnit: String, CaseIterable {
    case minutes = "Minute(s)"
    case hours = "Hour(s)"
    case days = "Day(s)"
}

@Reducer
public struct AdultBlockingSession {
    @ObservableState
    public struct State: Equatable {
        var selectedNumber: Int = 7
        var selectedTimeUnit: TimeUnit = .days
        @Presents var destination: Destination.State?
    }

    public enum Action: ViewAction, BindableAction {
        case view(View)
        case delegate(Delegate)
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
    }

    public enum View {
        case setDurationButtonTapped
        case durationPickerConfirmButtonTapped
        case startBlockingAdultSessionButtonTapped
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case durationPicker
    }

    @CasePathable
    public enum Delegate {
        case startAdultBlockingSession(selectedNumber: Int, selectedTimeUnit: TimeUnit)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .view(.setDurationButtonTapped):
                state.destination = .durationPicker
                return .none
            case .view(.startBlockingAdultSessionButtonTapped):
                return .send(.delegate(.startAdultBlockingSession(selectedNumber: state.selectedNumber,
                                                                  selectedTimeUnit: state.selectedTimeUnit)))
            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}

struct AdultDurationPicker: View {
    @Perception.Bindable var store: StoreOf<AdultBlockingSession>

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        WithPerceptionTracking {
            VStack {
                Text("Duration")
                    .font(.title2)
                    .foregroundStyle(Color.white)

                HStack {
                    numberPicker
                    timeUnitPicker
                }

                Spacer()

                VStack(spacing: 15) {
                    Button("Confirm") {
                        store.send(.view(.durationPickerConfirmButtonTapped))
                        dismiss()
                    }
                    .buttonStyle(CapsuleButtonStyle())
                }
            }
            .padding(20)
            .background(AppTheme.Colors.sectionViewColor)
        }
    }

    var numberPicker: some View {
        WithPerceptionTracking {
            Picker("", selection: $store.selectedNumber) {
                ForEach(Array(1...100), id: \.self) {
                    Text("\($0)")
                        .foregroundStyle(Color.white)
                }
            }
            .pickerStyle(.wheel)
        }
    }

    var timeUnitPicker: some View {
        WithPerceptionTracking {
            Picker("", selection: $store.selectedTimeUnit) {
                ForEach(TimeUnit.allCases, id: \.self) {
                    Text($0.rawValue)
                        .foregroundStyle(Color.white)
                }
            }
            .pickerStyle(.wheel)
        }
    }
}

#Preview {
    AdultDurationPicker(store: Store(initialState: AdultBlockingSession.State()) {
        AdultBlockingSession()
    })
}
