
//  HapticSlider.swift
//  JinGam
//
//  Created by 김준성 on 6/18/24.
//

import SwiftUI

struct HapticSlider: View {
    let title: String
    
    @Binding var value: Double
    let range: ClosedRange<Double>
    let step: Double
    
    init(
        title: String,
        value: Binding<Double>,
        in range: ClosedRange<Double>,
        step: Double
    ) {
        self.title = title
        self._value = value
        self.range = range
        self.step = step
        
        let image = UIImage(systemName: "circle.fill")?
            .withTintColor(.red, renderingMode: .alwaysOriginal)
        UISlider.appearance().setThumbImage(image, for: .normal)
    }
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(.white)
                .frame(maxWidth: 100)
            Slider(value: $value, in: range, step: step)
                .tint(.gray)
        }
    }
}

#Preview {
    VStack {
        HapticSlider(title: "Intensity", value: .constant(0.4), in: 0.2...1, step: 0.2)
        HapticSlider(title: "Sharpness", value: .constant(0.4), in: 0.2...1, step: 0.2)
    }
}
