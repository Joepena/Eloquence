//
//  OnboardStepFourVC.swift
//  Eloquence
//
//  Created by Jacob Ville on 1/22/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

protocol OnboardingUseEntryDelegate {
    func useWordsWereEntered(sentence: String)
}

class OnboardStepFourVC: UIViewController {
    
    var delegate: OnboardingUseEntryDelegate?
    
    @IBOutlet weak var wordsToUseTextField: OnboardTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        // Update parent UIPageVC of name which was entered
        delegate?.useWordsWereEntered(sentence: wordsToUseTextField.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
