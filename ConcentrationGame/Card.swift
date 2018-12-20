//
//  Card.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 12/20/18.
//  Copyright © 2018 Vitalij Semenenko. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
    var identifier: Int
    var isFaceUp = false
    var isMatched = false
    
    private static var lastCreatedIdentifier = 1
    
    init() {
        identifier = Card.lastCreatedIdentifier
        Card.lastCreatedIdentifier += 1
    }
    
    var hashValue: Int {
        return identifier
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
}
