//
//  pomodoroApp.swift
//  pomodoro
//
//  Created by Michael Sun on 5/24/24.
//

import SwiftUI
import UserNotifications

@main
struct pomodoroApp: App {
    
    var body: some Scene {
        WindowGroup {
            contentView().environmentObject(timeInfo())
        }
    }
}
