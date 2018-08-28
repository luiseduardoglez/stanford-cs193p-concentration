//
//  Shuffle.swift
//  concentration
//
//  Created by Luis Eduardo Gonzalez on 2018-08-28.
//  Copyright © 2018 Luis Eduardo Glez. All rights reserved.
//

import Foundation

extension MutableCollection {
    mutating func shuffle() {
        let numberOfItems = count
        guard numberOfItems > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: numberOfItems, to: 1, by: -1)) {
            let distance: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let indx = index(firstUnshuffled, offsetBy: distance)
            swapAt(firstUnshuffled, indx)
        }
    }
}

extension Sequence {
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
