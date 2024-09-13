//
//  File.swift
//  
//
//  Created by Raul Mena on 6/2/24.
//

import ComposableArchitecture
import SwiftUI
import Home

@Reducer
public struct ScreenSentry {
    @ObservableState
    public struct State: Equatable {
        public var selectedTab: Tab = .home
        public var home = HomeFeature.State()
        public var profile = HomeFeature.State()

        public enum Tab: Equatable {
            case home
            case profile
        }
        
        public init() {}
    }
    
    public enum Action {
        case home(HomeFeature.Action)
        case profile(HomeFeature.Action)
    }
    
    public init() {}
    
    public var body: some ReducerOf<Self> {
        Scope(state: \.home, action: \.home) {
            HomeFeature()
        }
        Scope(state: \.profile, action: \.profile) {
            HomeFeature()
        }
    }
}
