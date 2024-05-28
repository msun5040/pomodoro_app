//
//  titleView.swift
//  pomodoro
//
//  Created by Michael Sun on 5/25/24.
//

import SwiftUI

struct titleView: View {
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 15
    
    var body: some View {
        VStack {
            Text("Pomodoro")
                .font(Font.custom("Dosis-Bold", size: 30))
                .foregroundColor(Color(red:144/250, green: 212/250, blue: 145/250))
            .padding(scaledPadding)
        }
        
    }
}

#Preview {
    titleView()
}
