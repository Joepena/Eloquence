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
    
    static func postProcessSentiment(paragraph: String, dashboardVC: ViewController){
        
        Network.sentimentIndex(speech: paragraph) { (_score, _sentiment) in
            guard let score = _score, let sentiment = _sentiment else {
                print("[ERROR]: Woops, didn't get anything...")
                return
            }
            print("Got score: \(score)")
            print("Got sentiment: \(sentiment)")
            
            dashboardVC.updateSentiment(sentiment: sentiment,score: score)
        }
    }
}
