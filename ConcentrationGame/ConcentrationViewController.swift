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
    var emojis = ["🙈","👍","🤷‍♂️","⚾️","🎾","😂","🐶","🐱","🦊","🐏","🐺","🤯","🐷","🦃","🐭"]
    
    var flipCounts = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCounts)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            flipCounts += 1
            updateViewFromModel()
        } else {
            print("Card are not in Buttons List!")
        }
    }
    
    func updateViewFromModel() {
        for (cardIndex, card) in game.cardsList.enumerated() {
            if card.isFaceUp {
                cardButtons[cardIndex].backgroundColor = .green
                cardButtons[cardIndex].setTitle(emojis[card.identifier], for: .normal)
            } else {
                cardButtons[cardIndex].backgroundColor = .black
                cardButtons[cardIndex].setTitle("", for: .normal)
            }
        }
    }

}

