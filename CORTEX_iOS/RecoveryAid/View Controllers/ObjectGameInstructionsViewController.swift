//
//  ObjectGameInstructionsViewController.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import UIKit
import AVFoundation

class ObjectGameInstructionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func hearInstructions(_ sender: Any) {
        let string = "Welcome to Object Recognizer! Point the camera at different objects. Press anywhere on the screen to bring up the quiz module, then correctly answer what kind of object you're pointing the device camera at."
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
