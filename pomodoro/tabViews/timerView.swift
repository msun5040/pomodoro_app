import SwiftUI
import Combine

enum Phase {
    case session
    case shortBreak
    case longBreak
}

struct timerView: View {
    @EnvironmentObject var timing: timeInfo
    
    @State private var timeRemaining: TimeInterval = 10
    @State private var startTime: Date?
    @State private var timer: Timer?
    @State private var isRunning: Bool = false
    
    // Pause
    @State private var isPaused: Bool = false
    @State private var pausedTime: Double = 0
    
    // Settings Configuration
    @State private var numSessions: Int = 0
    @State private var sessionLen: Double = 0.0
    @State private var shortBreakLen: Double = 0.0
    @State private var longBreakLen: Double = 0.0
    @State private var longBreakInterval: Int = 0
    
    // Counters
    @State private var longBreakIntervalCounter: Int = 0
    @State private var sessionCounter: Int = 0
    @State private var shortBreaksCount: Int = 0
    @State private var workSessionsCounter: Int = 0
    
    // Time Logic
    @State private var currentPhase: Phase = .session
    @State private var timeLen: Double = 50
    
    
    @State private var showAlert: Bool = false
    
    @ScaledMetric(relativeTo: .body) var scaledPadding: CGFloat = 15
    
    
    var body: some View {
        VStack(alignment: .center) {
            let totalWorkSessions = Float(numSessions*(longBreakInterval+1))
            ProgressView(value: Float(workSessionsCounter) / totalWorkSessions) {
                Text("Progress")
            }
                .padding()
                .tint(Color(red: 190/255, green: 255/255, blue: 190/255))

            
            ZStack {
                Circle()
                    .stroke(lineWidth: 20)
                    .opacity(0.3)
                    .padding(scaledPadding)
                    .onAppear {
                        setTimes()
                    }
                
                Circle()
                    .trim(from: 0, to: CGFloat(timeRemaining / self.timeLen))
                    .stroke(
                        Color(red: 144/255, green: 212/255, blue: 145/255),
                        style: StrokeStyle(
                            lineWidth: 20,
                            lineCap: .round
                        )
                    )
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 0.75), value: timeRemaining)
                    .padding(scaledPadding)
                    
                
                Text(formattedTime())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
            }
            
            HStack {
                Button(action: {
                    isRunning.toggle()
                    if isRunning {
                        startTimer(phase: currentPhase)
                    } else {
                        pauseTimer()
                    }
                }) {
                    Image(systemName: isRunning ? "pause.fill" : "play.fill")
                        .frame(width: 50, height: 50)
                        .font(.largeTitle)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    stopTimer()
                }) {
                    Image(systemName: "stop.fill")
                        .frame(width: 50, height: 50)
                        .font(.largeTitle)
                }
                .buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    stopTimer()
                    setTimes()
                    resetCounters()
                    showAlert = true
                    
                }) {
                    Image(systemName: "arrow.counterclockwise")
                        .frame(width: 50, height: 50)
                        .font(.largeTitle)
                }
                .buttonStyle(PlainButtonStyle())
                
                

            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Pomodoro reset"),
                    dismissButton: .default(Text("OK")) {
                    }
                )
            }
        
    }
    
    private func formattedTime() -> String {
        let mins = Int(timeRemaining) / 60
        let secs = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", mins, secs)
    }
    
    private func setTimes() {
        self.longBreakInterval = Int(timing.longBreakInterval) ?? 0
        self.numSessions = Int(timing.numSessions) ?? 0
        self.shortBreakLen = Double(timing.shortBreakLenMins)
        self.longBreakLen = Double(timing.longBreakLenMins)
        
        let sessionLen = Double(timing.sessionLenMins)
        self.timeLen = sessionLen
        self.sessionLen = sessionLen
        self.timeRemaining = sessionLen
        
    }
    
    private func startTimer(phase: Phase) {
        startTime = Date()
        switch phase {
        case .session:
            self.timeLen = Double(sessionLen)
        case .shortBreak:
            self.timeLen = Double(shortBreakLen)
        case .longBreak:
            self.timeLen = Double(longBreakLen)
        }
        timer = Timer.scheduledTimer(withTimeInterval: 0.03, repeats: true) { _ in
            if let startTime = self.startTime {
                let elapsedTime = Date().timeIntervalSince(startTime)
                self.timeRemaining = max(self.timeLen - elapsedTime, 0)
                if self.timeRemaining <= 0 {
                    self.timerEndpoint()
                }
            }
        }
    }
    
    private func timerEndpoint() {
        stopTimer()
        
        if sessionCounter != numSessions{
            switch currentPhase {
            case .session:
                workSessionsCounter += 1
                if longBreakIntervalCounter == longBreakInterval {
                    currentPhase = .longBreak
                    longBreakIntervalCounter = 0
                } else {
                    currentPhase = .shortBreak
                    longBreakIntervalCounter += 1
                }
            case .shortBreak:
                shortBreaksCount += 1
                currentPhase = .session
            case .longBreak:
                sessionCounter += 1
                shortBreaksCount = 0
                currentPhase = .session
            }
            startTimer(phase: currentPhase)
        } else {
            sessionCounter = 0
        }
    }

    private func pauseTimer() {
        self.pausedTime = timeRemaining
        timer?.invalidate()
        timer = nil
        isPaused = true
    }
    
    private func stopTimer() {
        isRunning = false
        timer?.invalidate()
        timer = nil
        timeRemaining = self.timeLen
        startTime = nil
    }
    
    private func resetCounters() {
        workSessionsCounter = 0
        sessionCounter = 0
        shortBreaksCount = 0
        longBreakIntervalCounter = 0
    }
}

#Preview {
    timerView().environmentObject(timeInfo())
}
