//
//  ViewController.swift
//  Eloquence
//
//  Created by Joseph Pena on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //record button component
    @IBOutlet weak var recordButton: UIButton!
    
    //dashboard components
    var sentimentPercentage: Float? = nil
    var sentimentlabel: String? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BackgroundImageLoader.loadBackground(imageName: "dashboard-bg", vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func avoidButtonPressed(_ sender: Any) {
        print("transparent avoid button pressed lol")
    }
    func updateSentiment(sentiment:String, score:Float) {
        //takes a completion and uses the data to populate fields
        print ("Update Score: \(score)")
        print("Update Sentiment: \(sentiment)")
        sentimentlabel = sentiment
        sentimentPercentage = score
    }


}

