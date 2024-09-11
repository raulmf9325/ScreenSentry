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
    public static let liveValue = Self(requestAccess: requestLocalNotificationsAccess, 
                                       scheduleNotification: scheduleLocalNotification)
}

func requestLocalNotificationsAccess() async throws -> LocalNotificationsAccess {
    let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound])
    return granted ? .granted : .denied
}

func scheduleLocalNotification(title: String, subtitle: String, targetDate: Date) {
    let content = UNMutableNotificationContent()
    content.title = title
    content.subtitle = subtitle
    content.sound = UNNotificationSound.default

    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: targetDate.timeIntervalSinceNow, repeats: false)
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
    UNUserNotificationCenter.current().add(request)
}
