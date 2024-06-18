//
//  CapsuleButtonStyle.swift
//  JinGam
//
//  Created by 김준성 on 6/17/24.
//

import SwiftUI

struct MinRoundRectButtonStyle: ButtonStyle {
    let cornerRadius:CGFloat
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundStyle(.white)
            .padding()
            .frame(width: 148, height: 45)
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(color))
    }
}

struct MaxRoundRectButtonStyle: ButtonStyle {
    let cornerRadius:CGFloat
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .bold()
            .foregroundStyle(.white)
            .padding()
            .frame(height: 45)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: cornerRadius).fill(color))
    }
}
