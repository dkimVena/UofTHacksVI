//
//  EmotionGame.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import Foundation

enum Emotion: String {
    case Happy
    case Neutral
    case Sad
    case Fear
    case Disgust
    case Angry
    case Surprise
}

class EmotionGame{

    var allEmotions = [Emotion.Happy, Emotion.Neutral, Emotion.Sad, Emotion.Fear, Emotion.Disgust, Emotion.Angry, Emotion.Surprise]
    var prevelantEmotion: Emotion = .Happy
    var prevelantEmotionIndex: Int {
        get{
            switch prevelantEmotion {
            case .Happy:
                return 0
            case .Neutral:
                return 1
            case .Sad:
                return 2
            case .Fear:
                return 3
            case .Disgust:
                return 4
            case .Angry:
                return 5
            case .Surprise:
                return 6
            }
        }
    }

}
