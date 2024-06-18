//
//  PlayerControllable.swift
//  JinGam
//
//  Created by 김준성 on 6/18/24.
//

import Foundation

protocol PlayerControllable {
    func startTimer(timeInterval: TimeInterval, handler: @escaping (Timer) -> Void)
    func resetTimer()
}
