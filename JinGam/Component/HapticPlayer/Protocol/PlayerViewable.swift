//
//  PlayerViewable.swift
//  JinGam
//
//  Created by 김준성 on 6/18/24.
//

import SwiftUI

protocol PlayerViewable: View {
    var totalSeconds: Double { get }
    var playerController: PlayerControllable { get }
    var playHandler: () -> Void { get }
    var resetHandler: () -> Void { get }
}
