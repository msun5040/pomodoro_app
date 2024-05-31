//
//  contentView.swift
//  pomodoro
//
//  Created by Michael Sun on 5/25/24.
//

import SwiftUI
import UserNotifications

struct contentView: View {
    
    @StateObject var timing = timeInfo()
    
    var body: some View {

        VStack {
            TabView() {
                timerView(timerNotificationHandler: sendNotification)
                    .tabItem {
                        Text("Home")
                    }
                settingsView()
                    .tabItem {
                        Text("Settings")
                    }
            }
            .padding()
            .environmentObject(timing)
        }
        .onAppear {
                    requestNotificationAuthorization()
                }
    }
    
    private func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                print("Authorization granted")
            } else if !granted {
                print("Authorization denied")
            } else {
                print(error?.localizedDescription as Any)
            }
        }
    }

    private func sendNotification() {
        print("inside")
        let content = UNMutableNotificationContent()
        content.title = "Timer Done!"
        content.body = "Your current phase is complete."
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
        UNUserNotificationCenter.current().add(request)
    }

    
    
}


#Preview {
    contentView()
}
