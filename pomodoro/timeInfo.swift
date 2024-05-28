//
//  timeInfo.swift
//  pomodoro
//
//  Created by Michael Sun on 5/26/24.
//

import SwiftUI

@MainActor class timeInfo: ObservableObject {
    @Published var numSessions = "1"
    @Published var sessionLen = "25"
    @Published var shortBreakLen = "5"
    @Published var longBreakLen = "10"
    @Published var longBreakInterval = "2"
    
    var sessionLenMins: Double {
        return (Double(sessionLen) ?? 0) * 60
    }

    var shortBreakLenMins: Double {
        return (Double(shortBreakLen) ?? 0.0) * 60
    }
        
    var longBreakLenMins: Double {
        return (Double(longBreakLen) ?? 0.0) * 60
    }

}

