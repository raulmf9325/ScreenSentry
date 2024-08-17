//
//  CountdownTimer.swift
//
//
//  Created by Raul Mena on 8/14/24.
//

import ComposableArchitecture
import Foundation

@Reducer
public struct CountdownTimer {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init(targetDate: Date) {
            self.targetDate = targetDate
            @Dependency(\.date.now) var now
            self.timeRemaining = targetDate.timeIntervalSince(now)
        }

        let targetDate: Date
        var timeRemaining: TimeInterval

        public var daysLeft: Int { Int(timeRemaining / 86400) }
        public var hoursLeft: Int { Int(timeRemaining.truncatingRemainder(dividingBy: 86400) / 3600) }
        public var minutesLeft: Int { Int(timeRemaining.truncatingRemainder(dividingBy: 3600) / 60) }
        public var secondsLeft: Int { Int(timeRemaining.truncatingRemainder(dividingBy: 60)) }
    }

    public enum Action: Equatable {
        case restart
        case timerTicked
        case timerFinished
    }

    enum CancelID { case timer }

    @Dependency(\.continuousClock) var clock

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .restart:
                return .run { send in
                    await withTaskCancellation(id: CancelID.timer, cancelInFlight: true) {
                        for await _ in clock.timer(interval: .seconds(1)) {
                            await send(.timerTicked)
                        }
                    }
                }

            case .timerTicked:
                guard state.timeRemaining > 0 else { return .send(.timerFinished) }

                state.timeRemaining -= 1
                return .none

            case .timerFinished:
                return .cancel(id: CancelID.timer)
            }
        }
    }
}
