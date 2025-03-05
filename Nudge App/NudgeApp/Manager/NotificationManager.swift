//
//  NotificationManager.swift
//  NudgeApp
//
//  Created by CP on 20/02/25.
//

import UserNotifications

class NotificationManager {
    
    static var shared = NotificationManager()
    private var arrNotificationQuotes = [
        "Success is not final, failure is not fatal: it is the courage to continue that counts.",
        "Believe you can and you're halfway there.",
        "The only limit to our realization of tomorrow is our doubts of today.",
        "Don't watch the clock; do what it does. Keep going.",
        "The future depends on what you do today.",
        "It always seems impossible until it's done.",
        "Opportunities don't happen. You create them.",
        "Dream big and dare to fail.",
        "Hardships often prepare ordinary people for an extraordinary destiny.",
        "Do what you can, with what you have, where you are."
    ]
        
    let motivationalWords = [
        "Believe",
        "Achieve",
        "Persist",
        "Focus",
        "Courage",
        "Inspire",
        "Grow",
        "Thrive",
        "Create",
        "Empower"
    ]
    
    private let center = UNUserNotificationCenter.current()
    
    func scheduleNotifications() {
        self.center.removeAllPendingNotificationRequests()
        let calendar = Calendar.current
        let now = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: now)
        
        
        for hour in 0..<24 {
            for minute in [0, 30] {
                components.hour = hour
                components.minute = minute
                
                if let notificationDate = calendar.date(from: components) {
                    let quote = self.arrNotificationQuotes.randomElement() ?? "Are you following your routine?"
                    let word = self.motivationalWords.randomElement() ?? "Believe"
                    self.scheduleNotification(at: notificationDate, title: "\(word)!", body: quote)
                }
            }
        }
    }
    
    func scheduleNotification(at date: Date, title: String, body: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let notificationId = "Reminder_\(triggerDate.hour!)_\(triggerDate.minute!)"
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        
        self.center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
    
    func removeAllNotifications() {
        self.center.removeAllPendingNotificationRequests()
    }
}
