//
//  ConcentrationModel.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 12/20/18.
//  Copyright © 2018 Vitalij Semenenko. All rights reserved.
//

import Foundation

class Concentration {
    
    var cardsList: [Card]
    
    init(cardsCount: Int) {
        cardsList = [Card]()
        let numberOfPairsOfCards = cardsCount / 2
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cardsList += [card, card]
        }
        cardsList.shuffle()
    }
    
    func chooseCard(at index: Int) {
        cardsList[index].isFaceUp = !cardsList[index].isFaceUp
        print("Card with identifier: \(cardsList[index].identifier) isFaseUp: \(cardsList[index].isFaceUp)")
    }
    
}
