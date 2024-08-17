//
//  LocalNotificationsApiLive.swift
//
//
//  Created by Raul Mena on 8/13/24.
//

import Dependencies
import Foundation
import LocalNotificationsAPI
import UserNotifications

extension LocalNotificationsAPI: DependencyKey {
    public static let liveValue = Self(requestAccess: requestLocalNotificationsAccess)
}

func requestLocalNotificationsAccess() async throws -> LocalNotificationsAccess {
    let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
    return granted ? .granted : .denied
}

func scheduleNotification(title: String, subtitle: String) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // add our notification request
    UNUserNotificationCenter.current().add(request)
}
