//
//  AudioProcessor.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation
import AVFoundation
import googleapis
import WatchKit

let SAMPLE_RATE = 16000

class AudioProcessor : AudioControllerDelegate {
    var audioData: NSMutableData!
    
    var spokenSentences: [String] = []
    //DASHBOARD REFERENCE
    var dashboard: ViewController?
    
    init() {
        AudioController.sharedInstance.delegate = self
        
    }
    
    func recordAudio(parent:ViewController?) {
        
        let audioSession = AVAudioSession.sharedInstance()
        //parent to dashboard then place in stopAudio call
        dashboard = parent
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
        } catch {
            print("Error starting audio session")
        }
        
        audioData = NSMutableData()
        _ = AudioController.sharedInstance.prepare(specifiedSampleRate: SAMPLE_RATE)
        SpeechRecognitionService.sharedInstance.sampleRate = SAMPLE_RATE
        _ = AudioController.sharedInstance.start()
    }
    
    func stopAudio() {
        _ = AudioController.sharedInstance.stop()
        SpeechRecognitionService.sharedInstance.stopStreaming()
        print("Stopped Streaming")
        
        //logic for finding good and bad words
        
        var paragraphSpoken = ""
        
        // Dump stored sentences and process
        
        
        for sentence in self.spokenSentences {
            print(sentence)
            paragraphSpoken+=sentence
        }
        
        
        
        
        //dashboard reference
        SpeechTextProcessor.postProcessSentiment(paragraph: paragraphSpoken,dashboardVC: dashboard!)
        // Clear it
        self.spokenSentences.removeAll()
    }
    
    func processSampleData(_ data: Data) {
        audioData.append(data)
        
        // Thry recommend sending samples in 100ms chunks
        let chunkSize : Int /* bytes/chunk */ = Int(0.1 /* seconds/chunk */
            * Double(SAMPLE_RATE) /* samples/second */
            * 2 /* bytes/sample */);
        
        if (audioData.length > chunkSize) {
            SpeechRecognitionService.sharedInstance.streamAudioData(audioData, completion:
                {(response, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    } else if let response = response {

                        print("got some data")
                        
                        for result in response.resultsArray! {
                            if let result = result as? StreamingRecognitionResult {
                                if result.isFinal {
                                    
                                    print("got finalized text:\n")
                                    
                                    if let recognitionAlternative = result.alternativesArray.firstObject as! SpeechRecognitionAlternative? {
                                        print("got thru")
                                        let lastSentence = recognitionAlternative.transcript
                                        self.spokenSentences.append(lastSentence!)
                                        SpeechTextProcessor.processText(text: lastSentence!)
//                                        print(lastSentence)
                                        
                                    }
                                }
                            }
                        }
                        
                    }
                
            })
            self.audioData = NSMutableData()
        }
    }
    
}
