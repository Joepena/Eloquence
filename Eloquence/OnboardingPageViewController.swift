//
//  OnboardingPageViewController.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import UIKit

// Good Tutorial: https://github.com/ThornTechPublic/Onboarding-With-UIPageViewController-Starter

protocol OnboardCompletionDelegate {
    func onboardDidComplete(user: User)
}

class OnboardingPageViewController: UIPageViewController, OnboardingNameEntryDelegate {

    var nameEntered: String = ""
    
    var onboardDelegate: OnboardCompletionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set color behind dots
//        view.backgroundColor = UIColor.init(red: 220.0, green: 220.0, blue: 220.0, alpha: 0.3)
        view.backgroundColor = .lightGray
        
        // Set datasource
        dataSource = self
        
        // Set first view controller
        setViewControllers([getStepZero()], direction: .forward, animated: false, completion: nil)
        
        print("Hi, we're about to onboard you")
    }
    
    func getStepZero() -> OnboardStepZeroVC {
        return storyboard!.instantiateViewController(withIdentifier: "StepZero") as! OnboardStepZeroVC
    }
    
    func getStepOne() -> OnboardStepOneVC {
        let nameEntryView = storyboard!.instantiateViewController(withIdentifier: "StepOne") as! OnboardStepOneVC
        nameEntryView.delegate = self
        return nameEntryView
    }
    
    func getStepTwo() -> OnboardStepTwoVC {
        return storyboard!.instantiateViewController(withIdentifier: "StepTwo") as! OnboardStepTwoVC
    }
    
    func getStepThree() -> OnboardStepThreeVC {
        return storyboard!.instantiateViewController(withIdentifier: "StepThree") as! OnboardStepThreeVC
    }
    
    func nameWasEntered(name: String) {
        // Store name that was entered
        print("hello \(name)!!!!!")
        nameEntered = name
    }
    
    
    func finishOnboard() {
        // Create user with information
        let user = User(name: nameEntered, wordsToAvoid: ["hate", "no", "uh", "like", "terrible", "no one", "never", "um", "hell"], wordsToUse: ["yes", "I", "love" ], wordOfTheDay: "eloquence",lastSessionSentiment: 120.0)
        print("completed an onboarding for:")
        print(user)
        
        // Go back to parent
        
        // self.parent is IniitialViewController
        self.willMove(toParentViewController: self.parent)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        
        // Call container parent view controller
        onboardDelegate?.onboardDidComplete(user: user)
        
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

extension OnboardingPageViewController : UIPageViewControllerDataSource  {
    
    // Satrt at first dot when call setViewControllers()
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    // 4 dots
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return 4
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is OnboardStepThreeVC {
            // 3 -> 2
            return getStepTwo()
        } else if viewController is OnboardStepTwoVC {
            // 2 -> 1
            return getStepOne()
        } else if viewController is OnboardStepOneVC {
            // 1 -> 0
            return getStepZero()
        } else {
            // 0 -> end of the road, cant go back!
            return nil
        }
    }
    
    
    // Order of view controllers
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is OnboardStepZeroVC {
            // 0 -> 1
            return getStepOne()
        } else if viewController is OnboardStepOneVC {
            // 1 -> 2
            return getStepTwo()
        } else if viewController is OnboardStepTwoVC {
            // 2 -> 3
            return getStepThree()
        } else {
            // 3 -> end of the road
            finishOnboard()
            
            return nil
        }
    }
}
