//
//  HapticsManager.swift
//  SpotifyApp
//
//  Created by Balsa Komnenovic on 13.2.23..
//

import UIKit

final class HapticsManager {
    /// Shared instance
    static let shared = HapticsManager()
    
    //MARK: - Init
    private init() {}
    
    //MARK: - Public
    public func vibrateForSelection() {
        DispatchQueue.main.async {
            let generator = UISelectionFeedbackGenerator()
            generator.prepare()
            generator.selectionChanged()
        }
    }
    
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        DispatchQueue.main.async {
            let generator = UINotificationFeedbackGenerator()
            generator.prepare()
            generator.notificationOccurred(type)
        }
    }
}
