//
//  App.swift
//  ScreenSentry
//
//  Created by Raul Mena on 5/5/24.
//

import AppCore
import ComposableArchitecture
import SwiftUI
import ScreenTimeApiLive

@main
struct ScreenSentryApp: App {
    let store = Store(initialState: ScreenSentry.State()) {
        ScreenSentry()
    }
    
    var body: some Scene {
        WindowGroup {
            AppTabView(store: store)
                .preferredColorScheme(.dark)
        }
    }
}
