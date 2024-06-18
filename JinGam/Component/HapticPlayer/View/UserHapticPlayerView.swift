//
//  UserHapticPlayerView.swift
//  JinGam
//
//  Created by 김준성 on 6/17/24.
//

import SwiftUI

struct UserHapticPlayerView: PlayerViewable {
    @Binding var hapticName: String
    let totalSeconds: Double
    let playHandler: () -> Void
    let resetHandler: () -> Void
    let playerController: PlayerControllable = PlayerController()
    
    @State private var isPlaying = false
    @State private var currentSeconds = 0.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 22)
            .foregroundStyle(.userHapticPlayer)
            .overlay {
                VStack(spacing: 16) {
                    TextField(
                        "",
                        text: $hapticName,
                        prompt: Text("진동의 이름을 입력해주세요.").foregroundStyle(.gray)
                    )
                    .font(.body)
                    .bold()
                    .foregroundStyle(.black)
                    ProgressView(value: currentSeconds, total: totalSeconds)
                        .progressViewStyle(.linear)
                        .tint(.red)
                    Button {
                        if isPlaying {
                            resetHandler()
                            resetTimer()
                        } else {
                            playHandler()
                            startTimer()
                        }
                    } label: {
                        let systemName = isPlaying ? "stop.fill" : "play.fill"
                        Image(systemName: systemName)
                            .resizable()
                            .foregroundColor(Color.black)
                            .frame(width: 40, height: 40)
                    }
                }
                .padding()
            }
    }
    
    private func startTimer() {
        isPlaying = true
        playerController.startTimer(timeInterval: 0.1) { _ in
            currentSeconds += 0.1
            if currentSeconds >= totalSeconds {
                resetTimer()
            }
        }
    }
    
    private func resetTimer() {
        isPlaying = false
        currentSeconds = 0.0
        playerController.resetTimer()
    }
}

#Preview {
    UserHapticPlayerView(hapticName: .constant(""), totalSeconds: 5) {  } resetHandler: {
        
    }
}
