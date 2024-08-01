//
//  File.swift
//  
//
//  Created by Raul Mena on 6/11/24.
//

import ComposableArchitecture
import FamilyControls
import ScreenTimeAPI

@Reducer
public struct StartBlockingSession {
    @ObservableState
    public struct State: Equatable {
        public init() {}
        
        var isShowingActivityPicker = false
        var activitySelection = FamilyActivitySelection()
        var durationInMinutes = 15
        var allowBreaks = false
    }
    
    
    public enum Action: ViewAction {
        case view(View)
        
        @CasePathable
        public enum View: BindableAction {
          case onSelectAppsButtonTapped
          case binding(BindingAction<State>)
        }
    }
    
    public init() {}
    
    @Dependency(\.screenTimeApi) var screenTimeApi
    
    public var body: some ReducerOf<Self> {
        BindingReducer(action: \.view)
        Reduce { state, action in
            switch action {
            case .view(.onSelectAppsButtonTapped):
                state.isShowingActivityPicker = true
                return .none
            
            case .view(.binding):
                return .none
            }
        }
    }
}
