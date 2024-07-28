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
public struct Home: Sendable {
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        var screenTimeAccess: ScreenTimeAccess = .notDetermined
        var isBlockingAdultContent = false
        @Presents var startBlockingSession: StartBlockingSession.State?
    }
    
    public enum Action: Sendable {
        case onHomeViewAppeared
        case requestScreenTimeApiAccess
        case screenTimeAccessResponse(ScreenTimeAccess)
        case onStartBlockingSessionButtonTapped
        case onBlockAdultContentTapped
        case updateIsBlockingAdultContent
        case startBlockingSession(PresentationAction<StartBlockingSession.Action>)
    }
    
    public init() {}
    
    @Dependency(\.screenTimeApi) var screenTimeApi
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onHomeViewAppeared:
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
            
            case .onStartBlockingSessionButtonTapped:
                state.startBlockingSession = StartBlockingSession.State()
                return .none
                
            case .startBlockingSession:
                return .none

            case .onBlockAdultContentTapped:
                screenTimeApi.blockAdultContent()
                return .none

            case .updateIsBlockingAdultContent:
                state.isBlockingAdultContent = screenTimeApi.isBlockingAdultContent()
                return .none
            }
        }
        .ifLet(\.$startBlockingSession, action: \.startBlockingSession) {
            StartBlockingSession()
        }
    }
}
