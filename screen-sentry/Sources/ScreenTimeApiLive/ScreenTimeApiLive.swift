//
//  File.swift
//  
//
//  Created by Raul Mena on 6/9/24.
//

import Dependencies
import FamilyControls
import Foundation
import ManagedSettings
import ScreenTimeAPI

extension ScreenTimeAPI: DependencyKey {
    public static let liveValue = Self(requestAccess: requestScreenTimeAccess,
                                       blockAdultContent: blockPornography,
                                       unblockAdultContent: unblockPornography,
                                       isBlockingAdultContent: isBlockingPornography)
}

@Sendable
func requestScreenTimeAccess() async throws -> ScreenTimeAccess {
    let authCenter = AuthorizationCenter.shared
    try await authCenter.requestAuthorization(for: .individual)
    
    switch authCenter.authorizationStatus {
    case .notDetermined:
        return .notDetermined
    case .denied:
        return.denied
    case .approved:
        return .approved
    @unknown default:
        return .denied
    }
}

@Sendable
func blockPornography() {
    let store = ManagedSettingsStore()
    store.webContent.blockedByFilter = .auto([], except: [])
}

@Sendable
func unblockPornography() {
    let store = ManagedSettingsStore()
    store.webContent.blockedByFilter = nil
}

@Sendable
func isBlockingPornography() -> Bool {
    let store = ManagedSettingsStore()
    return store.webContent.blockedByFilter != nil
}
