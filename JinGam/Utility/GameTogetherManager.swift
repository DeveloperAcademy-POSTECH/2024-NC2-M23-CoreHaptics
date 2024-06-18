//
//  GameTogetherManager.swift
//  JinGam
//
//  Created by 김준성 on 6/16/24.
//

import Combine
import Foundation
import GroupActivities

final class GameTogetherManager {
    private(set) var session: GroupSession<GameTogether>?
    private var messenger: GroupSessionMessenger?
    private var task: Task<Void, Never>?
    
    @Published private var haptic: Haptic?
    
    var hapticPublisher: AnyPublisher<Haptic?, Never> { 
        $haptic
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    deinit {
        task?.cancel()
    }
    
    func checkEligibleForGroupSession() -> Bool {
        GroupStateObserver().isEligibleForGroupSession
    }
    
    func startSharing() async {
        print("manager startSharing")
        let together = GameTogether()
        let result = await together.prepareForActivation()
        do {
            if result == .activationPreferred {
                _ = try await GameTogether().activate()
            } else {
                print(result)
            }
        } catch {
            print("error: \(error)")
        }
    }
    
    func setSessions() async {
        for await session in GameTogether.sessions() {
            configureSession(session)
        }
    }
    
    func send(_ haptic: Haptic) async throws {
        try await messenger?.send(haptic)
    }
    
    private func configureSession(_ session: GroupSession<GameTogether>) {
        let messenger = GroupSessionMessenger(session: session)
        let task = Task {
            for await (haptic, _) in messenger.messages(of: Haptic.self) {
                handle(haptic)
            }
        }
        
        self.session = session
        self.messenger = messenger
        self.task = task
            
        if session.state != .joined {
            session.join()
        }
    }

    private func handle(_ haptic: Haptic) {
        print(haptic)
        self.haptic = haptic
    }
}
