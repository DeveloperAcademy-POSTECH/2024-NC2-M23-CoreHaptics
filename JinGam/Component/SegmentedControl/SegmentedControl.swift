//
//  SegmentedControl.swift
//  JinGam
//
//  Created by 김준성 on 6/18/24.
//

import SwiftUI

typealias Segmentable = CaseIterable & Hashable & Identifiable & CustomStringConvertible
struct SegmentedControl<Segment: Segmentable>: View {
    let segments = Array(Segment.allCases)
    @Binding var selected: Segment
    @Namespace var name

    var body: some View {
        HStack(spacing: 0) {
            ForEach(segments, id: \.self) { segment in
                Button {
                    selected = segment
                } label: {
                    VStack {
                        Text(segment.description)
                            .fontWeight(.bold)
                            .foregroundColor(selected == segment ? Color(uiColor: .label) : Color(uiColor: .systemGray))
                        ZStack {
                            Capsule()
                                .fill(Color.clear)
                                .frame(height: 4)
                            if selected == segment {
                                Capsule()
                                    .fill(Color.userHapticPlayer)
                                    .frame(height: 4)
                                    .matchedGeometryEffect(id: "Tab", in: name)
                            }
                        }
                    }
                }
            }
        }
    }
}

fileprivate enum Temp: Segmentable {
    var id: Self { self }
    
    var description: String {
        switch self {
        case .hi:
            "HIHIHI"
        case .yo:
            "YoYoYo"
        }
    }
    
    case hi
    case yo
}

#Preview {
    SegmentedControl(selected: .constant(Temp.hi))
}
