//
//  File.swift
//  
//
//  Created by Raul Mena on 6/11/24.
//

import ComposableArchitecture
import ScreenTimeAPI

@Reducer
public struct StartBlockingSession: Sendable {
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        var durationInMinutes = 15
        var allowBreaks = false
    }
    
    public enum Action: Sendable {}
    
    public init() {}
    
    @Dependency(\.screenTimeApi) var screenTimeApi
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
