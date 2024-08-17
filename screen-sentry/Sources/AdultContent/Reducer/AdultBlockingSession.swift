//
//  AdultBlockingSession.swift
//
//
//  Created by Raul Mena on 8/14/24.
//

import ComposableArchitecture
import CountdownTimer
import Foundation

public enum TimeUnit: String, CaseIterable {
    case minutes = "Minute(s)"
    case hours = "Hour(s)"
    case days = "Day(s)"

    public var timeInterval: TimeInterval {
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
public struct AdultBlockingSession {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init(selectedNumber: Int = 7,
                    selectedTimeUnit: TimeUnit = .days) {
            self.selectedNumber = selectedNumber
            self.selectedTimeUnit = selectedTimeUnit

            @Dependency(\.date.now) var now
            self.timer = CountdownTimer.State(targetDate: now.addingTimeInterval(Double(selectedNumber) * selectedTimeUnit.timeInterval))
        }

        var selectedNumber: Int = 7
        var selectedTimeUnit: TimeUnit = .days
        var timer: CountdownTimer.State
        @Presents var destination: Destination.State?
    }

    public enum Action: ViewAction, BindableAction {
        case view(View)
        case delegate(Delegate)
        case binding(BindingAction<State>)
        case timer(CountdownTimer.Action)
        case destination(PresentationAction<Destination.Action>)
    }

    public enum View {
        case setDurationButtonTapped
        case durationPickerConfirmButtonTapped
        case startBlockingAdultSessionButtonTapped
        case blockingAdultContentViewAppeared
        case pauseBlockingAdultContentButtonTapped
        case deleteBlockingAdultContentButtonTapped
        case blockingAdultContentViewTapped
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case durationPicker
        case confirmPauseResumeDeleteAdultContent
    }

    @CasePathable
    public enum Delegate {
        case startAdultBlockingSession(selectedNumber: Int, selectedTimeUnit: TimeUnit)
        case pauseBlockingAdultContentButtonTapped
        case deleteBlockingAdultContentButtonTapped
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.timer, action: \.timer) {
            CountdownTimer()
        }

        Reduce { state, action in
            switch action {
            case .view(.setDurationButtonTapped):
                state.destination = .durationPicker
                return .none

            case .view(.startBlockingAdultSessionButtonTapped):
                return .send(.delegate(.startAdultBlockingSession(selectedNumber: state.selectedNumber,
                                                                  selectedTimeUnit: state.selectedTimeUnit)))
            case .view(.blockingAdultContentViewAppeared):
                return .send(.timer(.restart))

            case .view(.pauseBlockingAdultContentButtonTapped):
                return .send(.delegate(.pauseBlockingAdultContentButtonTapped))

            case .view(.deleteBlockingAdultContentButtonTapped):
                return .send(.delegate(.deleteBlockingAdultContentButtonTapped))

            case .view(.blockingAdultContentViewTapped):
                state.destination = .confirmPauseResumeDeleteAdultContent
                return .none

            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
