//
//  UseWordsModelAdapter.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/22/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation

class UseWordsModelAdapter: EditWordsDelegate {
    
    // User to base words off
    var user: User
    
    required init(user: User) {
        self.user = user
    }
    
    func getWords() -> [String] {
        return user.wordsToUse
        
    }
    func getBackgroundImageName() -> String {
        return "use-words-bg"
    }
    
    func getButtonImageName() -> String {
        return "add-use-word"
    }

    func updateWords(words: [String]) {
        // Change this user
        user.wordsToUse = words
        
        // Override and persist it
        User.encode(user: user)
    }
    
}
