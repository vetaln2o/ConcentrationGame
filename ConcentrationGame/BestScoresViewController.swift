//
//  BestScoresViewController.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 1/2/19.
//  Copyright © 2019 Vitalij Semenenko. All rights reserved.
//

import UIKit

class BestScoresViewController: UIViewController {
    
    @IBOutlet weak var bestScoresLabel: UILabel!
    @IBOutlet weak var bestFlipsLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let userDefaults = UserDefaults.standard
        
        if let bestScores = userDefaults.value(forKey: "BestScores") as? Int {
            bestScoresLabel.text = String(bestScores)
        }
        
        if let bestFlips = userDefaults.value(forKey: "BestFlipCount") as? Int {
            bestFlipsLabel.text = String(bestFlips)
        }
    }

}
