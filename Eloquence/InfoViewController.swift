//
//  InfoViewController.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!

    @IBAction func backButtonPressed(_ sender: Any) {
        print("back putton pressed")
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func signOutButtonPressed(_ sender: Any) {
        print("signout button pressed")
        
        // Delete currently signed in user
        let name = User.deleteCurrentUser()
        
        // Present alert "xxx has been signed out"
        let alert = UIAlertController(title: "User Deleted", message: "\(name) has been deleted.", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { action in
            // perhaps use action.title here
        })
        
        // Present alert
        self.present(alert, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("In info view controller")
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
