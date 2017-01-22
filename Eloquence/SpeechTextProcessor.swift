//
//  SpeechTextProcessor.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox


class SpeechTextProcessor {
    
    static func processText(text: String, completion: @escaping ([WordContainer]) -> Void ) {
        print("Processing...")
        print(text)
        let wordsToUse = User.getCurrentUser()?.wordsToUse
        
        let setOfGoodWords = Set(wordsToUse!.map({ $0 }))
        
        
        let wordsToAvoid = User.getCurrentUser()?.wordsToAvoid
        
        let setOfBadWords = Set(wordsToAvoid!)
        
        var wordsFound: [WordContainer] = []
        
        for word in text.components(separatedBy: " "){
            print(word)
            if setOfBadWords.contains(word){
                print("badWord")
                
                // Add to words found
                wordsFound.append(WordContainer(word: word, type: .bad))
                
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
                
            }
            else if setOfGoodWords.contains(word){
                print("Good word")
                wordsFound.append(WordContainer(word: word, type: .good))
                // Add to words found

            }
        }
        
        completion(wordsFound)

    }
    static func setupSentimentLabel(dashboardVC: ViewController) {
        let index = User.getCurrentUser()?.lastSessionSentiment
        
        if index! <= 80.0 && index! >= 0.0 {
            dashboardVC.positivityLabel.text = "negative"
            dashboardVC.positivityLabel.textColor = UIColor.red
        }
        else if index! >= 80.0 && index! <= 160.0 {
            dashboardVC.positivityLabel.text = "neutral"
            dashboardVC.positivityLabel.textColor = UIColor.gray
        } else {
            dashboardVC.positivityLabel.text = "happy"
            dashboardVC.positivityLabel.textColor = UIColor.green
        }
        
    }
    static func postProcessSentiment(paragraph: String, dashboardVC: ViewController){
        
        Network.sentimentIndex(speech: paragraph) { (_score, _sentiment) in
            guard let score = _score, let sentiment = _sentiment else {
                print("[ERROR]: Woops, didn't get anything...")
                return
            }
            print("Got score: \(score)")
            print("Got sentiment: \(sentiment)")
            
            let degreesOfSentiment = 120*score+120
            var user = User.getCurrentUser()
            user?.lastSessionSentiment = degreesOfSentiment
            User.encode(user: user!)
            
            setupSentimentLabel(dashboardVC: dashboardVC)
        }
    }
}
