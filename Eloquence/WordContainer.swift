//
//  WordContainer.swift
//  Eloquence
//
//  Created by Joseph Pena on 1/22/17.
//  Copyright © 2017 Joseph Pena. All rights reserved.
//

import Foundation

enum WordType {
    case good
    case bad
}

struct WordContainer {
    let word: String
    let type: WordType
}
