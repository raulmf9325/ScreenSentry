//
//  LocalNotificationsAPI.swift
//
//
//  Created by Raul Mena on 8/13/24.
//

import Dependencies
import DependenciesMacros
import Foundation

@DependencyClient
public struct LocalNotificationsAPI {
    public var requestAccess: () async throws -> LocalNotificationsAccess
    public var scheduleNotification: (String, String, Date) -> Void
}

public enum LocalNotificationsAccess {
    case granted
    case denied
    case notDetermined
}

extension DependencyValues {
  public var localNotificationsAPI: LocalNotificationsAPI {
    get { self[LocalNotificationsAPI.self] }
    set { self[LocalNotificationsAPI.self] = newValue }
  }
}

extension LocalNotificationsAPI: TestDependencyKey {
  public static let testValue = Self()
}
