//
//  BestScoresViewController.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 1/2/19.
//  Copyright © 2019 Vitalij Semenenko. All rights reserved.
//

import UIKit

class BestScoresViewController: UIViewController {
    
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.presentationController?.presentationStyle == .popover {
            closeButton.isHidden = true
        }
    }
    
    @IBAction func closeScoresInfo(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
