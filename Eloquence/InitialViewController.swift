//
//  InitialViewController.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit
import RealmSwift


class InitialViewController: UIViewController, OnboardCompletionDelegate {
    
    
    // Check if a user has been saved
    let user: User? = {
        return User.getCurrentUser()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Check if any users have been saved
        if let user = user {
            // If so, go to the dashboard
            print("We have a user saved!")
            print(user)
            loadDashboard()
        } else {
            // otherwise, present onboarding
            print("No users! Lets make some")
            loadOnboarding()
            
        }
        
        
        // No user, get outta here
        guard let user = user else {
            return
        }
        
        // Modifying words to avoid and not modifiying original user
        // Since it copies by value
//        var myUser = user
//        myUser.wordsToAvoid = ["Gonzalo"]
//        
//        print(user.wordsToAvoid)
//        print(myUser.wordsToAvoid)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func loadOnboarding() {
        let onboardingVC = self.storyboard?.instantiateViewController(withIdentifier: "OnboardingViewController") as? OnboardingPageViewController
        
        // Set completion delegate and add to subviews
        onboardingVC?.onboardDelegate = self
        self.addChildViewController(onboardingVC!)
        self.view.addSubview((onboardingVC?.view)!)
        
        onboardingVC?.didMove(toParentViewController: self)
        onboardingVC?.view.frame = self.view.frame
        
        
    }
    
    func loadDashboard() {
//        let dashboardVC = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController")
        let dashboardNavContoller = self.storyboard?.instantiateViewController(withIdentifier: "DashboardNavController")
        
        self.addChildViewController(dashboardNavContoller!)
        self.view.addSubview((dashboardNavContoller?.view)!)
        
        dashboardNavContoller?.didMove(toParentViewController: self)
        dashboardNavContoller?.view.frame = self.view.frame
    }
    
    //MARK: OnboardCompleteionDelegate
    
    func onboardDidComplete(user: User) {
        print("back at initial")
        
        // Save this user!
        User.encode(user: user)
        
        loadDashboard()
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
