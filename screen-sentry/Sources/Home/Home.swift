//
//  File.swift
//  
//
//  Created by Raul Mena on 6/2/24.
//

import AdultContent
import ComposableArchitecture
import Foundation
import ScreenTimeAPI
import StartBlockingSession
import SwiftUI

@Reducer
public struct Home {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {}

        var screenTimeAccess: ScreenTimeAccess = .notDetermined
        var adultBlockingSession: AdultBlockingSession.State?
        @Presents var destination: Destination.State?

        var isBlockingAdultContent: Bool {
            @Dependency(\.screenTimeApi) var screenTimeApi
            return screenTimeApi.isBlockingAdultContent()
        }
    }
    
    public enum Action: ViewAction {
        case view(View)
        case requestScreenTimeApiAccess
        case screenTimeAccessResponse(ScreenTimeAccess)
        case adultBlockingSession(AdultBlockingSession.Action)
        case resumeAdultBlockingSession
        case destination(PresentationAction<Destination.Action>)
    }
    
    @CasePathable
    public enum View {
        case homeViewAppeared
        case startBlockingSessionButtonTapped
        case templateAdultContentButtonTapped
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case startBlockingSession(StartBlockingSession)
        case confirmStartBlockingAdultContent(AdultBlockingSession)
    }
    
    @Dependency(\.screenTimeApi) var screenTimeApi
    @Dependency(\.defaultAppStorage) var appStorage

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.homeViewAppeared):
                return .send(.requestScreenTimeApiAccess)
                       .merge(with: .send(.resumeAdultBlockingSession))

            case .requestScreenTimeApiAccess:
                return .run { send in
                    do {
                        let access = try await screenTimeApi.requestAccess()
                        await send(.screenTimeAccessResponse(access))
                    } catch {
                        print("Error requesting screen time access: \(error)")
                        await send(.screenTimeAccessResponse(.denied))
                    }
                }

            case let .screenTimeAccessResponse(access):
                state.screenTimeAccess = access
                return .none

            case .resumeAdultBlockingSession:
                if state.isBlockingAdultContent && state.adultBlockingSession == nil {
                    state.adultBlockingSession = AdultBlockingSession.State()
                } else {
                    state.adultBlockingSession = nil
                }
                return .none

            case .view(.startBlockingSessionButtonTapped):
                state.destination = .startBlockingSession(StartBlockingSession.State())
                return .none

            case .view(.templateAdultContentButtonTapped):
                state.destination = .confirmStartBlockingAdultContent(AdultBlockingSession.State())
                return .none

            case let .destination(.presented(.confirmStartBlockingAdultContent(.delegate(.startAdultBlockingSession(selectedNumber, selectedTimeUnit))))):
                if case let .confirmStartBlockingAdultContent(adultSession) = state.destination {
                    withAnimation {
                        state.adultBlockingSession = adultSession
                    }
                }
                return .run { _ in
                    await screenTimeApi.blockAdultContent()
                    let unblockDate = Date.now.addingTimeInterval(Double(selectedNumber) * selectedTimeUnit.timeInterval)
                    appStorage.adultUnblockDate = unblockDate
                }

            case .adultBlockingSession(.delegate(.deleteBlockingAdultContentButtonTapped)),
                 .adultBlockingSession(.delegate(.pauseBlockingAdultContentButtonTapped)):
                return .run { send in
                    await screenTimeApi.unblockAdultContent()
                    await send(.resumeAdultBlockingSession, animation: .linear)
                }

            case .destination, .adultBlockingSession:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
        .ifLet(\.adultBlockingSession, action: \.adultBlockingSession) {
            AdultBlockingSession()
        }
    }
}

extension UserDefaults {
    private static let adultUnblockDateKey = "adultUnblockDate"

    var adultUnblockDate: Date? {
        get {
            return UserDefaults.standard.object(forKey: Self.adultUnblockDateKey) as? Date
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Self.adultUnblockDateKey)
        }
    }
}
