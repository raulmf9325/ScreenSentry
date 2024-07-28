//
//  File.swift
//  
//
//  Created by Raul Mena on 6/9/24.
//

import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct ScreenTimeAPI: Sendable {
    public var requestAccess: @Sendable () async throws -> ScreenTimeAccess
    public var blockAdultContent: @Sendable () -> Void
    public var unblockAdultContent: @Sendable () -> Void
    public var isBlockingAdultContent: @Sendable () -> Bool = { false }
}

public enum ScreenTimeAccess: Sendable {
    case approved
    case denied
    case notDetermined
}

extension DependencyValues {
  public var screenTimeApi: ScreenTimeAPI {
    get { self[ScreenTimeAPI.self] }
    set { self[ScreenTimeAPI.self] = newValue }
  }
}

extension ScreenTimeAPI: TestDependencyKey {
  public static let testValue = Self()
}
