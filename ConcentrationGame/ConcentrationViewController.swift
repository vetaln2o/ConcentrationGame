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
    var gameTheme : Theme?
    var emojis = "🙈👍🤷‍♂️⚾️🎾😂🐶🐱🦊🐏🐺🤯🐷🦃🐭"
    var cardsEmojis = [Int:String]()
    
    var flipCounts = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCounts)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = gameTheme?.themeName
        view.backgroundColor = gameTheme?.backgroundColor ?? .white
        emojis = gameTheme?.emojisList ?? "🙈👍🤷‍♂️⚾️🎾😂🐶🐱🦊🐏🐺🤯🐷🦃🐭"
        updateViewFromModel()
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender), !game.cardsList[cardIndex].isMatched {
            game.chooseCard(at: cardIndex)
            flipCounts += 1
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton) {
        game = Concentration(cardsCount: cardButtons.count)
        flipCounts = 0
        emojis = gameTheme?.emojisList ?? "🙈👍🤷‍♂️⚾️🎾😂🐶🐱🦊🐏🐺🤯🐷🦃🐭"
        cardsEmojis = [Int:String]()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel() {
        if let themeOfGame = gameTheme {
            for (cardIndex, card) in game.cardsList.enumerated() {
                if !card.isMatched {
                    if card.isFaceUp {
                        cardButtons[cardIndex].backgroundColor = themeOfGame.flipedCardsColor
                        cardButtons[cardIndex].setAttributedTitle(
                            NSAttributedString(string: emoji(for: card.identifier),
                                               attributes: [NSAttributedString.Key.font : UIFont(descriptor: UIFontDescriptor(), size: 40)]), for: .normal)
                    } else {
                        cardButtons[cardIndex].backgroundColor = themeOfGame.unflipedCardsColor
                        cardButtons[cardIndex].setAttributedTitle(nil, for: .normal)
                    }
                } else {
                    cardButtons[cardIndex].backgroundColor = themeOfGame.backgroundColor
                    cardButtons[cardIndex].setAttributedTitle(nil, for: .normal)
                }
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

