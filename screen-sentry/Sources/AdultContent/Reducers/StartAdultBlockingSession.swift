//
//  StartAdultBlockingSession.swift
//
//
//  Created by Raul Mena on 8/16/24.
//

import ComposableArchitecture
import Foundation
import ScreenTimeAPI

public enum TimeUnit: String, CaseIterable {
    case minutes = "Minute(s)"
    case hours = "Hour(s)"
    case days = "Day(s)"

    var timeInterval: TimeInterval {
        switch self {
        case .minutes:
            return 60
        case .hours:
            return 3600
        case .days:
            return 86400
        }
    }
}

@Reducer
public struct StartAdultBlockingSession {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init(selectedNumber: Int = 7, selectedTimeUnit: TimeUnit = .days) {
            self.selectedNumber = selectedNumber
            self.selectedTimeUnit = selectedTimeUnit
        }
        
        var selectedNumber: Int = 7
        var selectedTimeUnit: TimeUnit = .days
        @Presents var destination: Destination.State?
    }

    public enum Action: ViewAction, BindableAction {
        case binding(BindingAction<State>)
        case view(View)
        case destination(PresentationAction<Destination.Action>)
        case delegate(Delegate)
    }

    public enum View {
        case setDurationButtonTapped
        case durationPickerConfirmButtonTapped
        case startBlockingAdultSessionButtonTapped
    }

    public enum Delegate {
        case adultBlockingSessionStarted
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case durationPicker
    }

    @Dependency(\.screenTimeApi) var screenTimeApi
    @Dependency(\.defaultAppStorage) var appStorage

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .view(.setDurationButtonTapped):
                state.destination = .durationPicker
                return .none

            case .view(.durationPickerConfirmButtonTapped):
                return .none

            case .view(.startBlockingAdultSessionButtonTapped):
                return .run { [number = state.selectedNumber, timeUnit = state.selectedTimeUnit ] send in
                    await screenTimeApi.blockAdultContent()
                    let unblockDate = Date.now.addingTimeInterval(Double(number) * timeUnit.timeInterval)
                    appStorage.adultUnblockDate = unblockDate
                    await send(.delegate(.adultBlockingSessionStarted))
                }

            case .destination, .binding, .delegate:
                return .none
            }

        }
        .ifLet(\.$destination, action: \.destination)
    }
}

extension UserDefaults {
    private static let adultUnblockDateKey = "adultUnblockDate"

    public var adultUnblockDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: Self.adultUnblockDateKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.adultUnblockDateKey)
        }
    }
}
