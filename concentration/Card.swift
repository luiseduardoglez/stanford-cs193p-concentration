//
//  Card.swift
//  concentration
//
//  Created by Luis Eduardo Gonzalez on 2018-04-08.
//  Copyright © 2018 Luis Eduardo Glez. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
