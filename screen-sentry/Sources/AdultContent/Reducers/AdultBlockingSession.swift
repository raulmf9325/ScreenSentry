//
//  AdultBlockingSession.swift
//
//
//  Created by Raul Mena on 8/14/24.
//

import ComposableArchitecture
import CountdownTimer
import Foundation

@Reducer
public struct AdultBlockingSession {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {
            @Dependency(\.defaultAppStorage) var appStorage
            self.timer = CountdownTimer.State(targetDate: appStorage.adultUnblockDate ?? Date.now.addingTimeInterval(-2600))
        }

        var timer: CountdownTimer.State
        @Presents var destination: Destination.State?
    }

    public enum Action: ViewAction {
        case view(View)
        case delegate(Delegate)
        case timer(CountdownTimer.Action)
        case destination(PresentationAction<Destination.Action>)
    }

    public enum View {
        case blockingAdultContentViewAppeared
        case blockingAdultContentViewTapped
        case pauseBlockingAdultContentButtonTapped
        case deleteBlockingAdultContentButtonTapped
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case confirmPauseResumeDeleteAdultContent
    }

    @CasePathable
    public enum Delegate {
        case pauseBlockingAdultContentButtonTapped
        case deleteBlockingAdultContentButtonTapped
    }

    public var body: some ReducerOf<Self> {
        Scope(state: \.timer, action: \.timer) {
            CountdownTimer()
        }

        Reduce { state, action in
            switch action {
            case .view(.blockingAdultContentViewAppeared):
                return .send(.timer(.restart))

            case .view(.blockingAdultContentViewTapped):
                state.destination = .confirmPauseResumeDeleteAdultContent
                return .none

            case .view(.pauseBlockingAdultContentButtonTapped):
                return .send(.delegate(.pauseBlockingAdultContentButtonTapped))

            case .view(.deleteBlockingAdultContentButtonTapped):
                return .send(.delegate(.deleteBlockingAdultContentButtonTapped))

            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
