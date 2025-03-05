//
//  AlarmManager.swift
//  NudgeApp
//
//  Created by CP on 04/03/25.
//

import Foundation
import UserNotifications
import AVFoundation

class Task {
    var time: String
    var name: String
    
    init(time: String, name: String) {
        self.time = time
        self.name = name
    }
}

class AlarmManager {
    
    static var shared = AlarmManager()
    
    private var audioPlayer: AVAudioPlayer?
    
    private let arrTasks = [
        Task(time: "00:00", name: "Sleep"),
        Task(time: "06:00", name: "Wake Up"),
        Task(time: "07:00", name: "Breakfast"),
        Task(time: "08:00", name: "Work on Personal Goals"),
        Task(time: "09:00", name: "Professional Development"),
        Task(time: "11:00", name: "Lunch Break"),
        Task(time: "12:00", name: "Job Applications"),
        Task(time: "14:00", name: "Skill Improvement"),
        Task(time: "18:00", name: "Dinner"),
        Task(time: "19:00", name: "Project Work"),
        Task(time: "21:00", name: "Relax & Refresh"),
        Task(time: "21:30", name: "Evening Learning Session")
    ]
    
    private let arrSongs = ["malevolent_sukuna", "gojo_riko", "gohan_anger", "phonk_1", "code_1", "code_2", "code_3", "code_4", "code_5", "code_6", "code_7"]
    
    private let center = UNUserNotificationCenter.current()

    func scheduleAlarms() {
        self.center.removeAllPendingNotificationRequests()
        let calendar = Calendar.current
        let now = Date()
        var components = calendar.dateComponents([.year, .month, .day], from: now)

        for task in arrTasks {
            let timeComponents = task.time.split(separator: ":")
            components.hour = Int(timeComponents.first!)
            components.minute = Int(timeComponents.last!)
            
            if let alarmDate = calendar.date(from: components) {
                self.scheduleAlarm(at: alarmDate, for: task)
            }
        }
    }
    
    func scheduleAlarm(at date: Date, for task: Task) {
        let content = UNMutableNotificationContent()
        content.title = "its \(task.time)".uppercased()
        content.body = "\(task.name.uppercased())"
        let song = self.arrSongs.randomElement() ?? "phonk_1"
        
        content.sound = UNNotificationSound(named: UNNotificationSoundName("\(song).mp3"))
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let alarmId = "Reminder_\(triggerDate.hour!)_\(triggerDate.minute!)"
        let request = UNNotificationRequest(identifier: alarmId, content: content, trigger: trigger)
        
        self.center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }

    
    func removeAllAlarms() {
        self.center.removeAllPendingNotificationRequests()
    }
}
