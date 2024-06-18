//
//  OtherHapticPlayerView.swift
//  JinGam
//
//  Created by 김준성 on 6/18/24.
//

import SwiftUI

struct OtherHapticPlayerView: PlayerViewable {
    let title: String
    let totalSeconds: Double
    let playerController: PlayerControllable = PlayerController()
    let playHandler: () -> Void
    let resetHandler: () -> Void
    
    @State private var isPlaying = false
    @State private var currentSeconds = 0.0
    
    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .foregroundStyle(.otherHapticPlayer)
            .overlay {
                HStack {
                    Button {
                        if isPlaying {
                            resetHandler()
                            resetTimer()
                        } else {
                            playHandler()
                            startTimer()
                        }
                    } label: {
                        let systemName = isPlaying ? "stop.circle.fill" : "play.circle.fill"
                        Image(systemName: systemName)
                            .renderingMode(.original)
                            .resizable()
                            .foregroundStyle(.black)
                            .frame(width: 46, height: 46)
                    }
                    
                    bodyView
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

extension OtherHapticPlayerView {
    @ViewBuilder
    private var bodyView: some View {
        VStack(spacing: 8) {
            Text(title)
                .bold()
                .foregroundStyle(.black)
            ProgressView(value: currentSeconds, total: totalSeconds)
                .progressViewStyle(.linear)
                .tint(.red)
        }
    }
}

#Preview {
    OtherHapticPlayerView(title: "하이하이 요요요", totalSeconds: 2.0) { } resetHandler: { }
}
