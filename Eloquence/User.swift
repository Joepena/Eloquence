//
//  User.swift
//  Eloquence
//
//  Created by Sergio Puleri on 1/21/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object {
    
    // MARK: Properties
    dynamic var name: String = ""
    dynamic var wordsToAvoid: [String] = []
    dynamic var wordsToUser: [String] = []
    dynamic var wordOfTheDay: String = ""
    
//
//    required init(name: String) {
//        super.init()
//        self.name = name
//        
//        // init empty lists
//        self.wordsToUser = []
//        self.wordsToAvoid = []
//        self.wordOfTheDay = ""
//    }
//    
//    
//    func save() {
//        do {
//            let realm = try Realm()
//            try realm.write {
//                realm.add(self)
//            }
//        } catch let error as NSError {
//            fatalError(error.localizedDescription)
//        }
//    }
//    
    
    
}
