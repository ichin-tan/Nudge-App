//
//  NotificationManager.swift
//  NudgeApp
//
//  Created by CP on 20/02/25.
//

import UserNotifications

class NotificationManager {
    
    static var shared = NotificationManager()
    private var arrNotificationQuotes = ["You need to Code! Time is going and there is a lot to learn.",
                                         "Think about your mom before wasting your time. Don't you wanna call her to Canada?",
                                         "Think about your dad before wasting your time. Don't you wanna call him to Canada?",
                                         "You wanna go into Google, remember? Get to work right away.",
                                         "Get up and work! You should be working when everyone is sleeping.",
                                         "Don’t stop until you’re proud of yourself.",
                                         "Go to bed with satisfaction.",
                                         "If you work hard, maybe you will be able to do something for your little brother and sister.",
                                         "Imagine yourself as your alter ego. In the tech world, be the unstoppable force that crushes every obstacle. Show no mercy, and claim your throne as the strongest.",
                                         "You should only be thinking about coding 24/7.",
                                         "When you meet another developer, you should feel superior. You should have more knowledge than that person. Still a lot to learn. A lot of books to read. Don't waste time.",
                                         "DSA, iOS Frameworks, System Design, Operating System, AI, ML. These much you have to learn. Don't waste time and get to work!",
                                         "Even if you have to do something after 30 minits, Do not waste your 30 minits. If you stay like this you will waste your time a lot and you will not even realize it.",
                                         "If you are reading this and if you are not being productive, Please get to work now in 3 2 1....",
                                         "Fall in love with coding. Build extra ordinary things and show off your work proudly. You are doing it for yourself cause you are so interested in it.",
                                         "Build AI ML Softwares. Ideas like Image recognition and sound processing are so intriguing. Get to work!",
                                         "Think of your mom before wasting time. Don’t you want to bring her to Canada one day?",
                                         "Your dad’s dreams matter too. Don’t waste time—work hard to bring him to Canada.",
                                         "Google is waiting for you. Remember your goal? Get back to work!",
                                         "Rise and grind! Success comes when you work while others rest.",
                                         "Coding should consume your thoughts, day and night.",
                                         "Aim to outshine every developer you meet. There’s always more to learn—books, skills, knowledge. Don’t waste time.",
                                         "DSA, iOS Frameworks, System Design, AI, ML—so much to master. Stop delaying and start now.",
                                         "If you’re not being productive, start now. 3… 2… 1… Get to work!",
                                         "Dive into AI and ML. Explore ideas like image recognition and sound processing. Start building today!",
                                         "Think of your mom’s smile. Work hard to make her proud and bring her to Canada.",
                                         "Your dad believes in you. Don’t let him down—grind now to bring him closer to your dreams.",
                                         "Google is calling your name. Remember why you started. Get back to work!",
                                         "Success is built while others sleep. Get up and make every moment count.",
                                         "End your day knowing you gave it your all. Satisfaction is the best reward.",
                                         "Your siblings look up to you. Work hard to create a better future for them.",
                                         "DSA, AI, ML, System Design—your toolkit is vast. Start mastering it today.",
                                         "If you’re not coding, you’re falling behind. Start now. 3… 2… 1… Go!",
                                         "Fall in love with the process. Build, create, and innovate—your passion will shine through.",
                                         "AI and ML are the future. Dive into projects like image recognition and sound processing—start today!",
                                         "Dream big, work harder. The tech world rewards those who never quit.",
                                         "Your passion for coding is your greatest asset. Use it to create something amazing.",
                                         "The world needs your ideas. Start coding and bring them to life."
                                         
    ]
    
    private var arrCharacters : [String] = ["Sukuna", "Gojo", "Isagi", "Bachira", "Rin", "Vegeta", "Guts", "Itachi", "Zoro", "Light", "King", "Do San", "Hacker", "Genius", "Chintan", "Elon Musk", "Mark Zuckerburg"]
    
    
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
                    let character = self.arrCharacters.randomElement() ?? "Chintan"
                    self.scheduleNotification(at: notificationDate, title: "Hey \(character)!", body: quote)
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
