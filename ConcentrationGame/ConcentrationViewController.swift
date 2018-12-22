//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 12/20/18.
//  Copyright © 2018 Vitalij Semenenko. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var flipCountLabel: UILabel!
    
    lazy var game = Concentration(cardsCount: cardButtons.count)
    var emojis = "🙈👍🤷‍♂️⚾️🎾😂🐶🐱🦊🐏🐺🤯🐷🦃🐭"
    var cardsEmojis = [Int:String]()
    
    var flipCounts = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCounts)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        print(cardsEmojis)
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender), !game.cardsList[cardIndex].isMatched {
            game.chooseCard(at: cardIndex)
            flipCounts += 1
            updateViewFromModel()
        } else {
            print("Card are not in Buttons List!")
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(cardsCount: cardButtons.count)
        print(game.cardsList.count)
        flipCounts = 0
        emojis = "🙈👍🤷‍♂️⚾️🎾😂🐶🐱🦊🐏🐺🤯🐷🦃🐭"
        cardsEmojis = [Int:String]()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel() {
        for (cardIndex, card) in game.cardsList.enumerated() {
            if !card.isMatched {
                if card.isFaceUp {
                    cardButtons[cardIndex].backgroundColor = .green
                    cardButtons[cardIndex].setTitle(emoji(for: card.identifier), for: .normal)
                } else {
                    cardButtons[cardIndex].backgroundColor = .black
                    cardButtons[cardIndex].setTitle("", for: .normal)
                }
            } else {
                cardButtons[cardIndex].backgroundColor = view.backgroundColor
                cardButtons[cardIndex].setTitle("", for: .normal)
            }
        }
    }
    
    func emoji(for cardWithIdentifier: Int) -> String {
        if cardsEmojis[cardWithIdentifier] == nil, emojis.count > 0 {
            let randomStringIndex = emojis.index(emojis.startIndex, offsetBy: Int(arc4random_uniform(UInt32(emojis.count))))
            cardsEmojis[cardWithIdentifier] = String(emojis.remove(at: randomStringIndex))
        }
        return cardsEmojis[cardWithIdentifier] ?? ""
    }

}

