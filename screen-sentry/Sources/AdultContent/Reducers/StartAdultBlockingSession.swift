//
//  StartAdultBlockingSession.swift
//
//
//  Created by Raul Mena on 8/16/24.
//

import ComposableArchitecture
import Foundation
import LocalNotificationsAPI
import ScreenTimeAPI

public enum TimeUnit: String, CaseIterable, Sendable {
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
public struct StartAdultBlockingSession: Sendable {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init(selectedNumber: Int = 7, 
                    selectedTimeUnit: TimeUnit = .days,
                    durationOption: DurationOption = .permanently) {
            self.selectedNumber = selectedNumber
            self.selectedTimeUnit = selectedTimeUnit
            self.durationOption = durationOption
        }

        public enum DurationOption: Int {
            case permanently
            case setDuration
        }

        var durationOption: DurationOption
        var selectedNumber: Int = 7
        var selectedTimeUnit: TimeUnit = .days
        @Presents var destination: Destination.State?

        var durationOptionIndex: Int {
            get { durationOption.rawValue }
            set { self.durationOption = DurationOption(rawValue: newValue) ?? .permanently }
        }
    }

    public enum Action: ViewAction, BindableAction, Sendable {
        case binding(BindingAction<State>)
        case view(View)
        case destination(PresentationAction<Destination.Action>)
        case delegate(Delegate)
    }

    public enum View : Sendable{
        case setDurationButtonTapped
        case durationPickerConfirmButtonTapped
        case startBlockingAdultSessionButtonTapped
    }

    public enum Delegate : Sendable{
        case adultBlockingSessionStarted
    }

    @Reducer(state: .equatable)
    public enum Destination: Sendable {
        case durationPicker
    }

    @Dependency(\.dismiss) var dismiss
    @Dependency(\.screenTimeApi) var screenTimeApi
    @Dependency(\.defaultAppStorage) var appStorage
    @Dependency(\.localNotificationsAPI) var localNotificationsApi

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
                return .run { [number = state.selectedNumber, 
                               timeUnit = state.selectedTimeUnit,
                               durationOption = state.durationOption] send in
                    screenTimeApi.blockAdultContent()

                    if durationOption == .setDuration {
                        let unblockDate = Date.now.addingTimeInterval(Double(number) * timeUnit.timeInterval)
                        appStorage.adultUnblockDate = unblockDate

                        let notificationAccess = try await localNotificationsApi.requestAccess()
                        if notificationAccess == .granted {
                            localNotificationsApi.scheduleNotification("Adult Blocking Session Ended",
                                                                       "Open to unblock adult content.",
                                                                       unblockDate)
                        }
                    }
                    await send(.delegate(.adultBlockingSessionStarted))
                    await dismiss()
                }

            case .destination, .binding, .delegate:
                return .none
            }

        }
        .ifLet(\.$destination, action: \.destination)
    }

    private func scheduleSessionEndedNotification() {

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
