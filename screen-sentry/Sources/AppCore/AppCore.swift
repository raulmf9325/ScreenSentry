//
//  File.swift
//  
//
//  Created by Raul Mena on 6/2/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
struct AppState {
    @ObservableState
    struct State: Equatable {
        
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
