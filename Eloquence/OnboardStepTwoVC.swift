//
//  OnboardStepTwoVC.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

class OnboardStepTwoVC: UIViewController {

    @IBOutlet weak var userGreeting: UILabel!
    var nameEntered: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        userGreeting.text = "Nice to meet you \(nameEntered!)"
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
