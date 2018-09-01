//
//  Concentration.swift
//  concentration
//
//  Created by Luis Eduardo Gonzalez on 2018-04-08.
//  Copyright © 2018 Luis Eduardo Glez. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    var indexOfOneAndOnlyFaceUpCard: Int?
    var flipCount = 0
    var score = 0
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    score += 2
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                } else {
                    if cards[index].isVisited {
                        score -= 1
                    }
                    if cards[matchIndex].isVisited {
                        score -= 1
                    }
                    cards[matchIndex].isVisited = true
                    cards[index].isVisited = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else {
                //either no cards or 2 cards are face up
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards.shuffle()
    }
}
