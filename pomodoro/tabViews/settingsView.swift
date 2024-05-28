//
//  settingsView.swift
//  pomodoro
//
//  Created by Michael Sun on 5/25/24.
//

import SwiftUI

struct settingsView: View {
    
    @EnvironmentObject var timing: timeInfo
    
    var body: some View {
        VStack {    
            VStack {
                HStack{
                    Text("Number of Sessions")
                    Spacer()
                    TextField("Number", text: $timing.numSessions)
                        .padding(.all)
                        .frame(width: 110.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }
                
                HStack{
                    Text("Session Length")
                    Spacer()
                    TextField("Minutes", text: $timing.sessionLen)
                        .padding(.all)
                        .frame(width: 110.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }
                
                HStack{
                    Text("Short Break Length")
                    Spacer()
                    TextField("Minutes", text: $timing.shortBreakLen)
                        .padding(.all)
                        .frame(width: 110.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }
                
                HStack{
                    Text("Long Break Length")
                    Spacer()
                    TextField("Minutes", text: $timing.longBreakLen)
                        .padding(.all)
                        .frame(width: 110.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }
                
                HStack{
                    Text("Long Break Interval")
                    Spacer()
                    TextField("Number", text: $timing.longBreakInterval)
                        .padding(.all)
                        .frame(width: 110.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                }
                
            }
            .padding()
            .font(Font.custom("Dosis-Bold", size: 15))

        }
    }
}

#Preview {
    settingsView().environmentObject(timeInfo())
}
