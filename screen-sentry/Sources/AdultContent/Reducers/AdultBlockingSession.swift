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
public struct AdultBlockingSession : Sendable{
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {
            @Dependency(\.defaultAppStorage) var appStorage

            if let unblockDate = appStorage.adultUnblockDate {
                self.timer = CountdownTimer.State(targetDate:  unblockDate)
                self.alwaysOn = false
            } else {
                self.alwaysOn = true
            }
        }

        var alwaysOn = false
        var timer: CountdownTimer.State?
        @Presents var destination: Destination.State?

        var timerLabel: String {
            guard !alwaysOn, let timer else { return "Indefinitely" }

            let days = timer.daysLeft
            let hours = timer.hoursLeft
            let minutes = timer.minutesLeft
            let seconds = timer.secondsLeft
            let format: (Int) -> String = { String(format: "%02d", $0) }

            switch (days, hours, minutes, seconds) {
            case (1..., _, _, _):
                return "\(format(days)) Days • \(format(hours)) Hours remaining"
            case (_, 1..., _, _):
                return "\(format(hours)) Hours • \(format(minutes)) Minutes remaining"
            case (_, _, 1..., _):
                return "\(format(minutes)) Minutes • \(format(seconds)) Seconds remaining"
            case (_, _, _, 0...):
                return "\(format(seconds)) Seconds remaining"
            default:
                return "Indefinitely"
            }
        }
    }

    public enum Action: ViewAction, Sendable {
        case view(View)
        case delegate(Delegate)
        case timer(CountdownTimer.Action)
        case destination(PresentationAction<Destination.Action>)
        case endSession
    }

    public enum View : Sendable{
        case blockingAdultContentViewAppeared
        case blockingAdultContentViewTapped
        case pauseBlockingAdultContentButtonTapped
        case deleteBlockingAdultContentButtonTapped
    }

    @Reducer(state: .equatable)
    public enum Destination: Sendable {
        case confirmPauseResumeDeleteAdultContent
    }

    @CasePathable
    public enum Delegate : Sendable{
        case adultBlockingSessionEnded
    }

    @Dependency(\.screenTimeApi) var screenTimeApi
    @Dependency(\.defaultAppStorage) var appStorage
    @Dependency(\.localNotificationsAPI) var localNotificationsApi

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.blockingAdultContentViewAppeared):
                return state.alwaysOn ? .none : .send(.timer(.restart))

            case .view(.blockingAdultContentViewTapped):
                state.destination = .confirmPauseResumeDeleteAdultContent
                return .none

            case .timer(.timerFinished):
                return .send(.endSession)

            case .view(.pauseBlockingAdultContentButtonTapped),
                    .view(.deleteBlockingAdultContentButtonTapped):
                return .send(.endSession)

            case .endSession:
                return .run { send in
                    screenTimeApi.unblockAdultContent()
                    appStorage.adultUnblockDate = nil
                    localNotificationsApi.removeNotification(LocalNotificationId.adultSessionEnded.rawValue)
                    await send(.delegate(.adultBlockingSessionEnded))
                }

            default:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .ifLet(\.timer, action: \.timer) {
            CountdownTimer()
        }
    }
}
