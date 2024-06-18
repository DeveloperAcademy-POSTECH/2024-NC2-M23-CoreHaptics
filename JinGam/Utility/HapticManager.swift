//
//  HapticManager.swift
//  JinGam
//
//  Created by 김준성 on 6/16/24.
//

import CoreHaptics

final class HapticManager {
    private let engine: CHHapticEngine
    private var player: CHHapticPatternPlayer?
    
    init(engine: CHHapticEngine) {
        self.engine = engine
    }
    
    init?() {
        do {
            let capablitity = CHHapticEngine.capabilitiesForHardware()
            
            if capablitity.supportsHaptics {
                let engine = try CHHapticEngine()
                self.engine = engine
                try engine.start()
                print("haptic manager return.")
            } else {
                print("haptic manager nil.")
                return nil
            }
        } catch {
            print(error)
            return nil
        }
    }
    
    deinit {
        stop()
        engine.stop()
    }
    
    func haptic(
        type: CHHapticEvent.EventType,
        intensity: Float,
        sharpness: Float,
        duration: Float
    ) throws {
        stop()
        
        let eventParams = [
            CHHapticEventParameter(parameterID: .hapticIntensity, value: intensity),
            CHHapticEventParameter(parameterID: .hapticSharpness, value: sharpness)
        ]
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: eventParams, relativeTime: 0, duration: TimeInterval(duration))
        let pattern = try CHHapticPattern(events: [event], parameters: [])

        player = try engine.makePlayer(with: pattern)
        start()
    }
    
    func haptic(for param: HapticEventParameterable) throws {
        try haptic(
            type: .hapticContinuous,
            intensity: param.intensity, sharpness: param.sharpness,
            duration: param.duration
        )
    }
    
    func start() {
        Task {
            try? player?.start(atTime: 0)
        }
    }
    
    func stop() {
        try? player?.stop(atTime: 0)
    }
}

protocol HapticEventParameterable {
    var intensity: Float { get }
    var sharpness: Float { get }
    var duration: Float { get }
}
