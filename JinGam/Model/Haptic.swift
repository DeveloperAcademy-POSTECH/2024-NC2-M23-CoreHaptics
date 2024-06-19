//
//  Haptic.swift
//  JinGam
//
//  Created by 김준성 on 6/16/24.
//

import Foundation

struct Haptic: Codable, Equatable, HapticEventParameterable {
    let name: String
    let intensity: Float
    let sharpness: Float
    let duration: Float
    
    static func randomHaptic() -> Haptic {
        let randomFloats: [Float] = [0.2, 0.4, 0.6, 0.8, 1]
        
        let intensity = randomFloats[(0...4).randomElement()!]
        let sharpness = randomFloats[(0...4).randomElement()!]
        let duration = (1...5).randomElement()!
        
        return Haptic(
            name: "Computer's Haptic",
            intensity: intensity,
            sharpness: sharpness,
            duration: Float(duration)
        )
    }
    
    init(
        name: String,
        intensity: Float,
        sharpness: Float,
        duration: Float
    ) {
        self.name = name
        self.intensity = intensity
        self.sharpness = sharpness
        self.duration = duration
    }
}
