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
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    lazy var game = Concentration(cardsCount: cardButtons.count)
    var gameTheme : Theme?
    private var defaultEmojis = "🙈👍🤷‍♂️⚾️🎾😂🐶🐱🦊🐏🐺🤯🐷🦃🐭"
    private var emojis = ""
    private var cardsEmojis = [Int:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = gameTheme?.themeName
        view.backgroundColor = gameTheme?.backgroundColor ?? .white
        emojis = gameTheme?.emojisList ?? defaultEmojis
        updateViewFromModel()
        
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender), !game.cardsList[cardIndex].isMatched {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        }
    }
    
    @IBAction func newGame(_ sender: UIButton? = nil) {
        game = Concentration(cardsCount: cardButtons.count)
        emojis = gameTheme?.emojisList ?? defaultEmojis
        cardsEmojis = [Int:String]()
        updateViewFromModel()
    }
    
    
    func updateViewFromModel() {
        if let themeOfGame = gameTheme {
            flipCountLabel.text = "Flips: \(game.flipCount)"
            scoreLabel.text = "Scores: \(game.scores)"
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
        if game.isGameOver() {
            showAlert(with: "Your scores: \(game.scores) for \(game.flipCount) flips")
        }
    }
    
    private func showAlert(with message: String) {
        let alert = UIAlertController(title: "The Game is over!", message: message, preferredStyle: .alert)
        let newGameAlertAction = UIAlertAction(title: "New game", style: .default) { (alert) in
            self.newGame()
        }
        alert.addAction(newGameAlertAction)
        self.present(alert, animated: true)
    }
    
    private func emoji(for cardWithIdentifier: Int) -> String {
        if cardsEmojis[cardWithIdentifier] == nil, emojis.count > 0 {
            let randomStringIndex = emojis.index(emojis.startIndex, offsetBy: Int(arc4random_uniform(UInt32(emojis.count))))
            cardsEmojis[cardWithIdentifier] = String(emojis.remove(at: randomStringIndex))
        }
        return cardsEmojis[cardWithIdentifier] ?? ""
    }

}

