//
//  PlayerController.swift
//  JinGam
//
//  Created by 김준성 on 6/18/24.
//

import Foundation

final class PlayerController: PlayerControllable {
    private var timer: Timer?
    
    func startTimer(timeInterval: TimeInterval, handler: @escaping (Timer) -> Void) {
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) {
            handler($0)
        }
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
    }
}
