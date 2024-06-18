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
    
    static func == (lhs: Haptic, rhs: Haptic) -> Bool {
        return lhs.intensity == rhs.intensity
        && lhs.sharpness == rhs.sharpness
        && lhs.duration == rhs.duration
    }
    
    static func randomHaptic() -> Haptic {
        let randomInts = [2, 4, 6, 8, 10]
        
        let intensity = randomInts[(0...4).randomElement()!]
        let sharpness = randomInts[(0...4).randomElement()!]
        let duration = (1...5).randomElement()!
        
        return Haptic(
            name: "Computer's Haptic",
            intensity: Float(intensity) / 10,
            sharpness: Float(sharpness) / 10,
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
