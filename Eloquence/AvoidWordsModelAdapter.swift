//
//  AvoidWordsModelAdapter.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/22/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation

class AvoidWordsModelAdapter: EditWordsDelegate {
    
    // User to base words off
    var user: User
    
    required init(user: User) {
        self.user = user
    }
    
    func getWords() -> [String] {
        return user.wordsToAvoid
        
    }
    func getBackgroundImageName() -> String {
        return "avoid-words-bg"
    }
    
    func updateWords(words: [String]) {
        // Change this user
        user.wordsToAvoid = words
        
        // Override and persist it
        User.encode(user: user)
    }

    
}
