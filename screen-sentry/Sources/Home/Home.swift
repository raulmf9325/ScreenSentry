//
//  File.swift
//  
//
//  Created by Raul Mena on 6/2/24.
//

import ComposableArchitecture

@Reducer
public struct Home {
    @ObservableState
    public struct State: Equatable {
        public init() {}
    }
    
    public enum Action {
        case incrementButtonTapped
        case decrementButtonTapped
        case resetButtonTapped
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
