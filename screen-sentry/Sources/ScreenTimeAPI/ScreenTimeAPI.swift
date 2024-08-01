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
public struct ScreenTimeAPI {
    public var requestAccess: () async throws -> ScreenTimeAccess
    public var blockAdultContent: () -> Void
    public var unblockAdultContent: () -> Void
    public var isBlockingAdultContent: () -> Bool = { false }
}

public enum ScreenTimeAccess {
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
