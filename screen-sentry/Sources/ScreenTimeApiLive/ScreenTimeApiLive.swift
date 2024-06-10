//
//  File.swift
//  
//
//  Created by Raul Mena on 6/9/24.
//

import Foundation
import ScreenTimeAPI

extension ScreenTimeAPI {
    public static let live = ScreenTimeAPI(requestAccess: requestScreenTimeAccess)
}

@Sendable
func requestScreenTimeAccess() async throws -> ScreenTimeAccess {
    return .denied
}
