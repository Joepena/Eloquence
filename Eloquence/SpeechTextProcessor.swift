//
//  SpeechTextProcessor.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation
import UIKit


class SpeechTextProcessor {
    
    static func processText(text: String) {
        print("Processing...")
        print(text)
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
