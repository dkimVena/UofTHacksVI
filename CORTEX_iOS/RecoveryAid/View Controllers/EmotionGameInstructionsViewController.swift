//
//  EmotionGameInstructionsViewController.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import UIKit
import AVFoundation


class EmotionGameInstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true

        // Do any additional setup after loading the view.
    }
 
    @IBAction func hearInstructions(_ sender: Any) {
        let string = "Welcome to Sweet Emotions! Point the camera at different people. Press anywhere on the screen to bring up the quiz module, then correctly answer what kind of expression your subject is wearing."
        let utterance = AVSpeechUtterance(string: string)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        let synth = AVSpeechSynthesizer()
        synth.speak(utterance)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
