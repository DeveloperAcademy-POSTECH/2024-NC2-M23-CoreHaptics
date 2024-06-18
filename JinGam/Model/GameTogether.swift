//
//  GameTogether.swift
//  JinGam
//
//  Created by 김준성 on 6/16/24.
//

import GroupActivities

struct GameTogether: GroupActivity {
    let metadata: GroupActivityMetadata
    
    init() {
        var metadata = GroupActivityMetadata()
        metadata.title = "게임 ㄱㄱ"
        metadata.supportsContinuationOnTV = false
        metadata.type = .generic
        
        self.metadata = metadata
    }
}
