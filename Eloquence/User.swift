//
//  User.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation


// Good stuff: http://swiftandpainless.com/nscoding-and-swift-structs/

struct User {
    let name: String
    var wordsToAvoid: [String]
    let wordsToUse: [String]
    let wordOfTheDay: String

    // Static func to return user read from storage
    // TODO: Not sure if better way to do this because everytime we access we need to read from file system...
    // we want to read once, and only re-read of a write has been made...
    static func getCurrentUser() -> User? {
        let instance = User.decode()
        return instance
    }
    
    // MARK: Encoding and Decoding through Helper Class
    static func encode(user: User) {
        let userClassObject = HelperClass(user: user)
        
        NSKeyedArchiver.archiveRootObject(userClassObject, toFile: HelperClass.path())
    }
    
    static func decode() -> User? {
        let userClassObject = NSKeyedUnarchiver.unarchiveObject(withFile: HelperClass.path()) as? HelperClass
        
        return userClassObject?.user
    }
    
    static func deleteCurrentUser() -> String {
        let currentSignedInUserName = getCurrentUser()?.name
        
        do {
            try FileManager.default.removeItem(atPath: HelperClass.path())
            print("Removal successful")
        } catch let error {
            print("Error: \(error.localizedDescription)")
        }
        
        return currentSignedInUserName!
    }
}

extension User {

    class HelperClass: NSObject, NSCoding  {
        
        // MARK: User struct as "var" property so its mutable as well as being optional in case it doesnt exisit
        var user: User?
        
        
        init(user: User) {
            self.user = user
            super.init()
        }
        
        class func path() -> String {
            let documentsPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first
            let path = documentsPath?.appending("/User")
            return path!
        }
        
        
        // MARK: NSCoding
        public required init?(coder aDecoder: NSCoder) {
            
            // Get strings
            guard let name = aDecoder.decodeObject(forKey: "name") as? String else { user = nil; super.init(); return nil }
            guard let wordOfTheDay = aDecoder.decodeObject(forKey: "wordOfTheDay") as? String else { user = nil; super.init(); return nil }
            
            // Get Arrays
            guard let wordsToAvoid = aDecoder.decodeObject(forKey: "wordsToAvoid") as? [String] else { user = nil; super.init(); return nil }
            guard let wordsToUse = aDecoder.decodeObject(forKey: "wordsToAvoid") as? [String] else { user = nil; super.init(); return nil }
            
            // We dont need to write a constructor for structs?
            user = User(name: name, wordsToAvoid: wordsToAvoid, wordsToUse: wordsToUse, wordOfTheDay: wordOfTheDay)
            
            super.init()
        }
        
        func encode(with aCoder: NSCoder) {
            // Use ! or ? .... ?
            aCoder.encode(user?.name, forKey: "name")
            aCoder.encode(user?.wordsToAvoid, forKey: "wordsToAvoid")
            aCoder.encode(user?.wordsToUse, forKey: "wordsToUse")
            aCoder.encode(user?.wordOfTheDay, forKey: "wordOfTheDay")
        }
    }

    
}
