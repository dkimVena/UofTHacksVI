//
//  ViewController.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-18.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import UIKit
import AVKit
import Vision

class EmotionGameViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    var emotionGame = EmotionGame()
    var buttonOptions = [UIButton]()
    var seconds = 0
    var totalPoints = 0 {
        didSet{
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(totalPoints) points", style: .plain, target: nil, action: nil)
        }
    }
    var activeEmotion: Emotion? {
        return Emotion(rawValue: identifierLabel.text?.components(separatedBy: "|")[0] ?? "Happy")
    }
    
    let identifierLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var buttonQuizMe: UIButton = {
        var button = UIButton(frame: CGRect(x: view.frame.midX - (view.frame.width - 20)/2, y: view.frame.height - 70, width: view.frame.width - 20, height: 40))
        button.setAttributedTitle(NSAttributedString(string: "Quiz Me", attributes: [.font : UIFont(name: "Avenir", size: 18.0)!]), for: .normal)
        button.backgroundColor = UIColor(named: "quizMeButton")
        button.addTarget(self, action:  #selector(setQuizUI(_:)), for: .touchUpInside)
        return button
    }()

    var responseTimer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(buttonQuizMe)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "\(totalPoints) points", style: .plain, target: nil, action: nil)
        self.tabBarController?.tabBar.isHidden = true

        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else { return }
        //Uncomment to use back camera
        //        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        
        
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
        
        setupIdentifierConfidenceLabel()
    }
    
    fileprivate func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        guard let model = try? VNCoreMLModel(for: CNNEmotions().model) else { return }
        let request = VNCoreMLRequest(model: model) { (finishedReq, err) in

            guard let results = finishedReq.results as? [VNClassificationObservation] else { return }
            guard let firstObservation = results.first else { return }
            
            
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(firstObservation.identifier)| \(firstObservation.confidence * 100)"
            }
            
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    @objc func setQuizUI(_ sender: UIButton){
        print("Active emotion: \(activeEmotion?.rawValue)")
        
        print("ID label: \(identifierLabel.text?.components(separatedBy: "|")[0])")
        
        emotionGame.prevelantEmotion = activeEmotion ?? Emotion.Happy
        seconds = 0
        responseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
            self.seconds += 1
        })
        buttonQuizMe.isHidden = true
        for (i, emotion) in emotionGame.allEmotions.enumerated(){
            let button = UIButton(frame: CGRect(x: view.frame.midX - 150, y: view.frame.height - 140 - (55 * CGFloat(i)), width: 300, height: 50))
            button.backgroundColor = .clear
            button.layer.borderColor = UIColor.white.cgColor
            button.layer.borderWidth = 1.5
            button.layer.cornerRadius = 25
            
            buttonOptions.append(button)
            button.setTitle(emotion.rawValue, for: .normal)
            button.addTarget(self, action: #selector(pressedOption(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
    }

    @objc func pressedOption(_ sender: UIButton){
        print("Seconds after correct press: \(seconds)")
        print("prevlent emotion after pressed option: \(emotionGame.prevelantEmotion.rawValue)")
        let correct = sender.currentTitle! == emotionGame.prevelantEmotion.rawValue
        for button in buttonOptions{
            if(button != sender){
                UIView.animate(withDuration: 1.0, animations: {
                    button.alpha = 0
                }) { (bool) in
                    button.removeFromSuperview()
                }
            }
        }
        FirebaseManager.shared.addEmotionRecognitionAttempt(correct)
        seconds = seconds == 0 ? 1 : seconds
        var points = correct ? Int(20 * (1.0/Double(seconds))) * 10 : 0
        totalPoints += points
        seconds = 0
        responseTimer?.invalidate()
        sender.backgroundColor = correct ? .green : .red
        
        let title = correct ? "Congratulations!" : "Sorry"
        let message = correct ?  "You successfully identified that the person is \(sender.titleLabel!.text!.lowercased()). \nYou earned +\(points) points" : "You said the person pictured was \(sender.titleLabel!.text!.lowercased()), but really they were \(emotionGame.prevelantEmotion.rawValue.lowercased())."
        
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self](timer) in
            sender.removeFromSuperview()
            let containerView = UIView(frame: CGRect(x: (self?.view.frame.midX ?? 0) - 150, y:  (self?.view.frame.midY ?? 0) - 150, width: 300, height: 150))
            containerView.backgroundColor = .white
            containerView.layer.cornerRadius = 20
            let congratsLabel = UILabel(frame: CGRect(x: 25, y: 10, width: 250, height: 20))
            congratsLabel.textAlignment = .center
            congratsLabel.attributedText = NSAttributedString(string: title, attributes: [.font : UIFont(name: "Avenir", size: 18.0)!])
            congratsLabel.textColor = .black
            let descriptionLabel = UILabel(frame: CGRect(x: 25, y: 40, width: 250, height: 120))
            descriptionLabel.attributedText = NSAttributedString(string: message, attributes: [.font : UIFont(name: "Avenir", size: 16.0)!])
            descriptionLabel.numberOfLines = 0
            containerView.addSubview(congratsLabel)
            containerView.addSubview(descriptionLabel)
            self?.view.addSubview(containerView)
            
            Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false) { [weak self](timer) in
                UIView.animate(withDuration: 1.0, animations: {
                    containerView.alpha = 0
                }) { (bool) in
                    containerView.removeFromSuperview()
                    self?.buttonQuizMe.isHidden = false
                }
            }
            
        }
    }
    
    
}

