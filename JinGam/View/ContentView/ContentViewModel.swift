//
//  ContentViewModel.swift
//  JinGam
//
//  Created by 김준성 on 6/16/24.
//

import Combine

final class ContentViewModel {
    private let gameTogetherManager = GameTogetherManager()
    private let hapticManager = HapticManager()
    
    private var subscriptions = Set<AnyCancellable>()
    
    @Published private var openGameSharingView: Bool = false
    @Published private var haptic: Haptic = Haptic.randomHaptic()
    
    var hapticsPublisher: AnyPublisher<Haptic, Never> { $haptic.eraseToAnyPublisher() }
    
    func bind() {
        gameTogetherManager.hapticPublisher
            .sink { [weak self] haptic in
                guard let haptic else {
                    self?.haptic = Haptic.randomHaptic()
                    return
                }
                
                self?.haptic = haptic
            }
            .store(in: &subscriptions)
    }
    
    func onAppear() {
        bind()
        Task {
            await gameTogetherManager.setSessions()
        }
    }
    
    func playHaptic(for haptic: Haptic) {
        hapticManager?.stop()
        do {
            try hapticManager?.haptic(for: haptic)
        } catch {
            print("playHaptic Error: \(error)")
        }
    }
    
    func playHaptic(intensity: Double, sharpness: Double, duration: Double) {
        hapticManager?.stop()
        do {
            try hapticManager?.haptic(
                type: .hapticContinuous,
                intensity: intensity.toFloat,
                sharpness: sharpness.toFloat,
                duration: duration.toFloat
            )
        } catch {
            print("playHaptic Error: \(error)")
        }
    }
    
    func resetHaptic() {
        hapticManager?.stop()
    }
    
    func send(hapticName: String, intensity: Double, sharpness: Double, duration: Double) {
        let haptic = Haptic(name: hapticName, intensity: intensity.toFloat, sharpness: sharpness.toFloat, duration: duration.toFloat)
        
        Task {
            if gameTogetherManager.session == nil {
                print("send...")
                await gameTogetherManager.startSharing()
            }
            
            do {
                try await gameTogetherManager.send(haptic)
            } catch {
                print(error)
            }
        }
    }
    
    func send(haptic: Haptic) {
        Task {
            print("send...")
            do {
                if gameTogetherManager.session == nil {
                    await gameTogetherManager.startSharing()
                }
                try await gameTogetherManager.send(haptic)
            } catch {
                print(error)
            }
        }
    }
    
    func checkSubmit(lhs: Haptic, rhs: (intensity: Double, sharpness: Double, duration: Double)) -> SubmitResult {
        let (intensity, sharpness, duration) = rhs
        let rhs = Haptic(
            name: "",
            intensity: intensity.toFloat,
            sharpness: sharpness.toFloat,
            duration: duration.toFloat
        )
        
        let isCorrect = lhs == rhs
        
        if isCorrect {
            haptic = Haptic.randomHaptic()
        }
        
        return isCorrect ? .success : .failure
    }
    
    func startSharing() {
        Task {
            await gameTogetherManager.startSharing()
        }
    }
    
    func changeMode(_ gameMode: GameMode) {
        if gameMode == .multi {
            if gameTogetherManager.session != nil {
                startSharing()
            } else {
                print("session is nil")
            }
        }
    }
}

extension ContentViewModel {
    enum GameMode: Segmentable {
        case solo
        case multi
        
        var id: Self { self }
        
        var description: String {
            switch self {
            case .solo:
                "1인 모드"
            case .multi:
                "2인 모드"
            }
        }
    }
}
