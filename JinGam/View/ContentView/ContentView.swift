//
//  ContentView.swift
//  JinGam
//
//  Created by 김준성 on 6/16/24.
//

import SwiftUI

struct ContentView: View {
    private var viewModel = ContentViewModel()
    
    @State private var gameMode = ContentViewModel.GameMode.solo
    @State private var submitResult: SubmitResult? = nil
    @State private var hapticName = ""
    @State private var haptic = Haptic(name: "nil", intensity: 0.6, sharpness: 0.6, duration: 3)
    @State private var intensity = 0.6
    @State private var sharpness = 0.6
    @State private var duration = 3.0
    @State private var isAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                headerView
                bodyView
                Spacer()
                footerView
            }
            .padding([.leading, .trailing])
            .navigationTitle("절대진감")
            .navigationBarTitleDisplayMode(.large)
            .onAppear(perform: viewModel.onAppear)
            .onReceive(viewModel.hapticsPublisher) {
                haptic = $0
            }
            .onChange(of: gameMode) { _, newValue in
                viewModel.changeMode(newValue)
            }
            .alert("결과", isPresented: $isAlert, presenting: submitResult) {
                Button("\($0)") { }
            }
        }
    }
}

extension ContentView {
    @ViewBuilder
    private var headerView: some View {
        SegmentedControl(selected: $gameMode)
    }
    
    @ViewBuilder
    private var bodyView: some View {
        VStack {
            VStack {
                HStack {
                    Text(gameMode == .solo ? "Computer" : "Other")
                    Spacer()
                }
                
                OtherHapticPlayerView(
                    title: haptic.name,
                    totalSeconds: Double(haptic.duration)
                ) {
                    viewModel.playHaptic(for: haptic)
                } resetHandler: {
                    viewModel.resetHaptic()
                }
                .frame(height: 88)
            }
            
            
            Divider()
                .frame(height: 2)
                .padding([.top, .bottom])
            
            HStack {
                Text("My Custom")
                Spacer()
            }
            
            UserHapticPlayerView(
                hapticName: $hapticName,
                totalSeconds: Double(duration)
            ) {
                viewModel.playHaptic(intensity: intensity, sharpness: sharpness, duration: duration)
            } resetHandler: {
                viewModel.resetHaptic()
            }
            .frame(height: 156)
            
            VStack {
                HapticSlider(title: "Intensity", value: $intensity, in: 0.2...1, step: 0.2)
                Divider()
                HapticSlider(title: "Sharpness", value: $sharpness, in: 0.2...1, step: 0.2)
                Divider()
                HapticSlider(title: "Duration", value: $duration, in: 1...5, step: 1)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(.black23))
        }
    }
    
    @ViewBuilder
    private var footerView: some View {
        if gameMode == .solo {
            Button("제출하기") {
                submitResult = viewModel.checkSubmit(lhs: haptic, rhs: (intensity: intensity, sharpness: sharpness, duration: duration))
                isAlert = true
            }
            .buttonStyle(MaxRoundRectButtonStyle(cornerRadius: 20, color: .red))
            .padding([.leading, .trailing])
        } else {
            HStack {
                Button("공유하기") {
                    viewModel.send(
                        hapticName: hapticName,
                        intensity: intensity,
                        sharpness: sharpness,
                        duration: duration
                    )
                }
                .buttonStyle(MinRoundRectButtonStyle(cornerRadius: 20, color: .blue))
                
                Spacer()
                
                Button("제출하기") {
                    submitResult = viewModel.checkSubmit(lhs: haptic, rhs: (intensity: intensity, sharpness: sharpness, duration: duration))
                    isAlert = true
                }
                .buttonStyle(MinRoundRectButtonStyle(cornerRadius: 20, color: .red))
            }
            .padding([.leading, .trailing])
        }
    }
}

fileprivate extension Double {
    var hundredInt: Int { Int(self * 100) }
}

#Preview {
    ContentView()
}
