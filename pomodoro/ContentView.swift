//
//  contentView.swift
//  pomodoro
//
//  Created by Michael Sun on 5/25/24.
//

import SwiftUI

struct contentView: View {
    
    @StateObject var timing = timeInfo()
    
    var body: some View {

        VStack {
            TabView() {
                timerView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                            .accentColor(Color(red: 144/255, green: 212/255, blue: 145/255))
                    }
                settingsView()
                    .tabItem {
                        Image(systemName: "person")
                        Text("Settings")
                    }
            }
            .padding()
            .environmentObject(timing)
        }
    }
    
}

#Preview {
    contentView()
}
