//
//  File.swift
//  
//
//  Created by Raul Mena on 6/9/24.
//

import Dependencies
import FamilyControls
import Foundation
import ScreenTimeAPI

extension ScreenTimeAPI: DependencyKey {
    public static let liveValue = Self(requestAccess: requestScreenTimeAccess,
                                       blockAdultContent: blockPornography)
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

func blockPornography() {

}
