//
//  NotificationManager.swift
//  exzo
//
//  Created by Deven Nathanael on 29/11/21.
//

import Foundation
import UserNotifications

final class NotificationManager: ObservableObject {
    var blastReady: Bool = true
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    static var sharedNM = NotificationManager()
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    func createLocalNotification(condition: String) {
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.sound = .default
        
        if condition == "Underlimit" {
            notificationContent.title = ""
            notificationContent.subtitle = "Your pond's temperature is under the minimum. Check your pond right away."
        } else if condition == "Upperlimit" {
            notificationContent.title = "Reach the maximum temperature!"
            notificationContent.subtitle = "Your pond's temperature is above the maximum. Check your pond right away."
        } else if condition == "Offline" {
            notificationContent.title = "Your device is offline!"
            notificationContent.subtitle = "Check your connection and re-open the app."
        }
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        blastReady = false
        DispatchQueue.main.asyncAfter(deadline: .now()+5) {
            self.blastReady = true
        }
    }
}
