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
    var scores = 0
    var flipCount = 0
    private var lastChosenCardIdentifier = [Int]()
    private var cardsForScoresCount = [Card]()
    
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
            flipCount += 1
            cardsList[index].isFaceUp = !cardsList[index].isFaceUp
            lastChosenCardIdentifier.append(index)
            cardsForScoresCount.append(cardsList[index])
            if lastChosenCardIdentifier.count == 3 {
                checkMatch(between: lastChosenCardIdentifier[0], and: lastChosenCardIdentifier[1])
                cardsList[lastChosenCardIdentifier[0]].isFaceUp = false
                cardsList[lastChosenCardIdentifier[1]].isFaceUp = false
                lastChosenCardIdentifier.remove(at: 0)
                lastChosenCardIdentifier.remove(at: 0)
            }
        }
    }
    
    private func checkMatch(between lastChosenCardIndex: Int, and newCardIndex: Int) {
        if cardsList[lastChosenCardIndex] == cardsList[newCardIndex] {
            cardsList[lastChosenCardIndex].isMatched = true
            cardsList[newCardIndex].isMatched = true
            scores += 2
            cardsForScoresCount = [Card]()
            cardsForScoresCount.append(cardsList[newCardIndex])
        } else {
            if cardsForScoresCount.count == 5 {
                var penaltiScore = false
                var tempCardsForScores = cardsForScoresCount
                for _ in 0...3 {
                    let deletedCard = tempCardsForScores.remove(at: 0)
                    if tempCardsForScores.contains(deletedCard) {
                        penaltiScore = true
                    }
                }
                if penaltiScore {
                    scores -= 1
                }
                cardsForScoresCount.remove(at: 0)
                cardsForScoresCount.remove(at: 0)
            }
        }
    }
    
    func isGameOver() -> Bool {
        var isGameOver = false
        let isNotMatchCardsCount = cardsList.filter { (card) -> Bool in
            return !card.isMatched
        }.count
        let isFaceUpCardsCount = cardsList.filter { (card) -> Bool in
            return (card.isFaceUp && !card.isMatched)
        }.count
        if isNotMatchCardsCount == 2 && isFaceUpCardsCount == 2 {
            isGameOver = true
        }
        return isGameOver
    }
    
}
