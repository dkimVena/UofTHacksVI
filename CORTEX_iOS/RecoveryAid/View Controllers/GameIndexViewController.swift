//
//  GameIndexViewController.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import UIKit
import AVFoundation

class GameIndexViewController: UIViewController {

    @IBOutlet var buttonSweetEmotions: UIButton!
    @IBOutlet var buttonMagnifyingGlass: UIButton!
    @IBOutlet var buttonFaceMatch: UIButton!
    
    @IBOutlet var buttonHearSweetEmotions: UIButton!
    @IBOutlet var buttonHearMagnifyingGlass: UIButton!
    @IBOutlet var buttonHearFaceMatch: UIButton!
    
    @IBOutlet var labelWelcome: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FirebaseManager.shared.getUserName { (userName) in
            if let userName = userName{
                self.labelWelcome.text = "Welcome, \(userName)!"
            }
        }
        
        buttonSweetEmotions.roundCorners([.topLeft, .bottomLeft], radius: 10)
        buttonMagnifyingGlass.roundCorners([.topLeft, .bottomLeft], radius: 10)
        buttonFaceMatch.roundCorners([.topLeft, .bottomLeft], radius: 10)
        buttonHearSweetEmotions.roundCorners([.topRight, .bottomRight], radius: 10)
        buttonHearMagnifyingGlass.roundCorners([.topRight, .bottomRight], radius: 10)
        buttonHearFaceMatch.roundCorners([.topRight, .bottomRight], radius: 10)

        let imageSweetEmotions = UIImage(named: "smile")
        let imageViewSweetEmotions = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: buttonSweetEmotions.frame.height - 5))
        imageViewSweetEmotions.image = imageSweetEmotions
        imageViewSweetEmotions.contentMode = .scaleAspectFit
        buttonSweetEmotions.addSubview(imageViewSweetEmotions)
        
        let imageMagnifyingGlass = UIImage(named: "search")
        let imageViewMagnifyingGlass = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: buttonMagnifyingGlass.frame.height - 5))
        imageViewMagnifyingGlass.image = imageMagnifyingGlass
        imageViewMagnifyingGlass.contentMode = .scaleAspectFit
        buttonMagnifyingGlass.addSubview(imageViewMagnifyingGlass)
        
        let imageFaceMatch = UIImage(named: "face-recognition")
        let imageViewFaceMatch = UIImageView(frame: CGRect(x: 10, y: 5, width: 40, height: buttonFaceMatch.frame.height - 5))
        imageViewFaceMatch.image = imageFaceMatch
        imageViewFaceMatch.contentMode = .scaleAspectFit
        buttonFaceMatch.addSubview(imageViewFaceMatch)
       
        let imageViewSpeaker1 = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        imageViewSpeaker1.image = UIImage(named: "speaker-white")
        imageViewSpeaker1.contentMode = .scaleAspectFit

        let imageViewSpeaker2 = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        imageViewSpeaker2.image = UIImage(named: "speaker-white")
        imageViewSpeaker2.contentMode = .scaleAspectFit

        let imageViewSpeaker3 = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        imageViewSpeaker3.image = UIImage(named: "speaker-white")
        imageViewSpeaker3.contentMode = .scaleAspectFit
        
        buttonHearSweetEmotions.addSubview(imageViewSpeaker1)
        buttonHearMagnifyingGlass.addSubview(imageViewSpeaker2)
        buttonHearFaceMatch.addSubview(imageViewSpeaker3)

    }

    @IBAction func hearSweetEmotions(_ sender: Any) {
        let string = "Sweet Emotions"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    @IBAction func hearMagnifyingGlass(_ sender: Any) {
        let string = "Magnifying Glass 2"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    @IBAction func hearFaceMatch(_ sender: Any) {
        let string = "Face Match"
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    
    @IBAction func hearGreeting(_ sender: Any) {
        let string = labelWelcome.text ?? ""
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
}
