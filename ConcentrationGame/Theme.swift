//
//  Theme.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 12/23/18.
//  Copyright © 2018 Vitalij Semenenko. All rights reserved.
//

import Foundation
import UIKit

class Theme {
    var themeName: String
    var emojisList: String
    var backgroundColor: UIColor
    var flipedCardsColor: UIColor
    var unflipedCardsColor: UIColor
    
    init(themeName: String, emojisList: String, backgroundColor: UIColor, flipedCardsColor: UIColor, unflipedCardsColor: UIColor) {
        self.themeName = themeName
        self.emojisList = emojisList
        self.backgroundColor = backgroundColor
        self.flipedCardsColor = flipedCardsColor
        self.unflipedCardsColor = unflipedCardsColor
    }
}
