//
//  RecordSpeechViewController.swift
//  Eloquence
//
//  Created by Joseph Pena on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

class RecordSpeechViewController: UIViewController, WordFoundInSpeechDelegate {

    @IBOutlet weak var rightWordLabel: UILabel!
    @IBOutlet weak var wrongWordLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    var timer = Timer()
    var startTime = TimeInterval()
    
    var wordAlertQueue: [WordContainer] = []
    
    // initialize audio streaming processor
    let audioProcessor = AudioProcessor()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wrongWordLabel.isHidden = true
        rightWordLabel.isHidden = true
        //let background = UIImage(named: "background.png")
        //self.view.backgroundColor = UIColor(patternImage: background)
        audioProcessor.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // Start timer
        //parent ViewController to dashboard
        let parent = self.presentingViewController?.childViewControllers[0].childViewControllers[0] as? ViewController
        //pass parent down the recordAudio method in order to achieve modification of state
        start()
        
        // Start recording
        self.audioProcessor.recordAudio(parent:parent)
    }
    
    @IBAction func didPressStopButton(_ sender: Any) {
        stop(sender: self)
        self.audioProcessor.stopAudio()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    private func start() {
        if !timer.isValid {
            let actionSelector : Selector = #selector(RecordSpeechViewController.updateTime)
            timer = Timer.scheduledTimer(timeInterval: 0.01, target:self, selector:actionSelector, userInfo: nil, repeats: true)
            startTime = NSDate.timeIntervalSinceReferenceDate
        }
    }
    
    @IBAction func stop(sender: AnyObject) {
        timer.invalidate()
    }
    
    func updateTime() {
        let currentTime = NSDate.timeIntervalSinceReferenceDate
        
        // Find the difference between current time and strart time
        var elapsedTime: TimeInterval = currentTime - startTime
        
        // calculate the minutes in elapsed time
        let minutes = UInt8(elapsedTime / 60.0)
        elapsedTime -= (TimeInterval(minutes) * 60)
        
        // calculate the seconds in elapsed time
        let seconds = UInt8(elapsedTime)
        elapsedTime -= TimeInterval(seconds)
        
        // find out the fraction of millisends to be displayed
        let fraction = UInt8(elapsedTime * 100)
        
        // add the leading zero for minutes, seconds and millseconds and store them as string constants
        let startMinutes  = minutes > 9 ? String(minutes):"0" + String(minutes)
        let startSeconds  = seconds > 9 ? String(seconds):"0" + String(seconds)
        let startFraction = fraction > 9 ? String(fraction):"0" + String(fraction)
        
        timerLabel.text = "\(startMinutes):\(startSeconds):\(startFraction)"
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideWrongWord() {
        UIView.animate(withDuration: 0.3, delay:2, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.wrongWordLabel.alpha = 0
        }, completion: { finished in
            self.wrongWordLabel.isHidden = true
        })
        

    }
    func showWrongWord(word: String) {
        // Set text
        self.wrongWordLabel.text = word
        
        // Animate in
        UIView.animate(withDuration: 0.3, animations: {
            self.wrongWordLabel.isHidden = false
        })
    }
    
    func hideGoodWord() {
        UIView.animate(withDuration: 0.3, delay:2, options:UIViewAnimationOptions.transitionFlipFromTop, animations: {
            self.rightWordLabel.alpha = 0
        }, completion: { finished in
            self.rightWordLabel.isHidden = true
        })
        
    }
    func showGoodWord(word: String) {
        // Set text (shud be good word label)
        self.rightWordLabel.text = word
        
        // Animate in
        UIView.animate(withDuration: 0.2, animations: {
             self.rightWordLabel.isHidden = false
        })
    }
    
    func showWord(word: WordContainer) {
        switch word.type {
        case .bad:
            showWrongWord(word: word.word)
            hideWrongWord()
            
            
            break
        case .good:
            
            showGoodWord(word: word.word)
            hideGoodWord()
            
        default:
            break
        }
    }
    // MARK: WordFoundInSpeechDelegate
    
    func wordFound(word: WordContainer) {
        // Always add it to the queue
        wordAlertQueue.append(word)
        
        // Show the first word in the queue
        let nextWord = wordAlertQueue.remove(at: 0)
        
        // Show the word
        showWord(word: nextWord )
        
        
    }
    
}
