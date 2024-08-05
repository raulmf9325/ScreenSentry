//
//  File.swift
//  
//
//  Created by Raul Mena on 6/2/24.
//

import ComposableArchitecture
import ScreenTimeAPI
import StartBlockingSession

@Reducer
public struct Home {
    public init() {}

    @ObservableState
    public struct State: Equatable {
        public init() {}
        var screenTimeAccess: ScreenTimeAccess = .notDetermined
        var isBlockingAdultContent: Bool = false
        @Presents var destination: Destination.State?
    }
    
    public enum Action: ViewAction {
        case view(View)
        case requestScreenTimeApiAccess
        case screenTimeAccessResponse(ScreenTimeAccess)
        case updateIsBlockingAdultContent
        case destination(PresentationAction<Destination.Action>)
    }
    
    @CasePathable
    public enum View {
        case homeViewAppeared
        case startBlockingSessionButtonTapped
        case templateAdultContentButtonTapped
        case confirmStartBlockingAdultContentButtonTapped
        case activeAdultBlockingButtonTapped
        case pauseBlockingAdultContentButtonTapped
        case deleteBlockingAdultContentButtonTapped
    }

    @Reducer(state: .equatable)
    public enum Destination {
        case startBlockingSession(StartBlockingSession)
        case confirmPauseResumeDeleteAdultContent
        case confirmStartBlockingAdultContent
    }
    
    @Dependency(\.screenTimeApi) var screenTimeApi
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .view(.homeViewAppeared):
                return .send(.requestScreenTimeApiAccess)
                    .merge(with: .send(.updateIsBlockingAdultContent))

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

            case .view(.startBlockingSessionButtonTapped):
                state.destination = .startBlockingSession(StartBlockingSession.State())
                return .none

            case .view(.templateAdultContentButtonTapped):
                state.destination = .confirmStartBlockingAdultContent
                return .none

            case .view(.confirmStartBlockingAdultContentButtonTapped):
                return .run { send in
                    screenTimeApi.blockAdultContent()
                    await send(.updateIsBlockingAdultContent, animation: .linear)
                }

            case .view(.activeAdultBlockingButtonTapped):
                state.destination = .confirmPauseResumeDeleteAdultContent
                return .none

            case .view(.pauseBlockingAdultContentButtonTapped), .view(.deleteBlockingAdultContentButtonTapped):
                return .run { send in
                    screenTimeApi.unblockAdultContent()
                    await send(.updateIsBlockingAdultContent, animation: .linear)
                }

            case .updateIsBlockingAdultContent:
                state.isBlockingAdultContent = screenTimeApi.isBlockingAdultContent()
                return .none
            
            case .destination:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination)
    }
}
