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
    
    // Segue destinations type
    var destinationType: EditWordsType = .NONE
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        BackgroundImageLoader.loadBackground(imageName: "dashboard-bg", vc: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func avoidWordsButtonPressed(_ sender: Any) {
        print("Editing avoid Words")
        
        // Set enum type of dest
        destinationType = .AVOID
        
        // Perform
        performSegue(withIdentifier: "EditWordsSegue", sender: self)
    }
    
    
    @IBAction func useWordsButtonPressed(_ sender: Any) {
        print("Editing USE Words")
        
        // Set enum type of dest
        destinationType = .USE
        
        // Perform
        performSegue(withIdentifier: "EditWordsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditWordsSegue" {
            
            // Get current user
            let user = User.getCurrentUser()
            
            let targetVC = segue.destination as? EditWordsViewController
            
            switch destinationType {
            case .AVOID:
                // Construct avoid delegate and set and set image view
                let delegate = AvoidWordsModelAdapter(user: user!)
                targetVC?.delegate = delegate
                break
            case .USE:
                // Construct use delegate and set and set image view
                let delegate = UseWordsModelAdapter(user: user!)
                targetVC?.delegate = delegate
                break
            case .NONE:
                break

            }
            
        }
    }
    
    func updateSentiment(sentiment:String, score:Float) {
        //takes a completion and uses the data to populate fields
        print ("Update Score: \(score)")
        print("Update Sentiment: \(sentiment)")
        sentimentlabel = sentiment
        sentimentPercentage = score
    }


}

