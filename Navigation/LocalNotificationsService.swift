//
//  LocalNotificationsService.swift
//  Navigation
//
//  Created by Yuliya Vodneva on 4.11.24.
//

import Foundation
import UserNotifications

final class LocalNotificationsService {
    
    private let categoryID = "categoryID"
    
    func requestPermission() {
        Task{
            try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
        }
    }
    
    func addNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Navigation"
        content.body = "Посмотрите последние обновления"
        content.sound = .default
        content.badge = 1
        content.userInfo = ["key": "value"]
        content.categoryIdentifier = categoryID
        
        var dateComponents = DateComponents()
        dateComponents.hour = 13
        dateComponents.minute = 18
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "update", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func registeForLatestUpdatesIfPossible() {
        registerCategory()
        requestPermission()
        addNotification()
    }
    
    private func registerCategory() {
        let action = UNNotificationAction(identifier: "actionID", title: "Delete", options: .destructive)
        let category = UNNotificationCategory(identifier: categoryID, actions: [action], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
}

