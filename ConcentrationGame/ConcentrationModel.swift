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
    private var lastChosenCardIdentifier = [Int]()
    
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
        if !lastChosenCardIdentifier.contains(index) {
            cardsList[index].isFaceUp = !cardsList[index].isFaceUp
            lastChosenCardIdentifier.append(index)
            if lastChosenCardIdentifier.count == 3 {
                checkMatch(between: lastChosenCardIdentifier[0], and: lastChosenCardIdentifier[1])
                cardsList[lastChosenCardIdentifier[0]].isFaceUp = false
                cardsList[lastChosenCardIdentifier[1]].isFaceUp = false
                lastChosenCardIdentifier.remove(at: 0)
                lastChosenCardIdentifier.remove(at: 0)            }
        }
    }
    
    private func checkMatch(between lastChosenCardIndex: Int, and newCardIndex: Int) {
        if cardsList[lastChosenCardIndex] == cardsList[newCardIndex] {
            cardsList[lastChosenCardIndex].isMatched = true
            cardsList[newCardIndex].isMatched = true
        }
    }
    
}
