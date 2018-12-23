//
//  ThemeChooserViewController.swift
//  ConcentrationGame
//
//  Created by Vitalij Semenenko on 12/23/18.
//  Copyright © 2018 Vitalij Semenenko. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var themeChooserTableView: UITableView! {
        didSet {
            themeChooserTableView.delegate = self
            themeChooserTableView.dataSource = self
        }
    }
    
    var gameThemes: [Theme] {
        return createThemesList()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Choose game theme"
    }
    
    func createThemesList() -> [Theme] {
        var themesList = [Theme]()
        themesList.append(Theme(themeName: "Helloween", emojisList: "😈👹👺🤡👻💀☠️👀🧠🤖🎃", backgroundColor: .black, flipedCardsColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), unflipedCardsColor: .orange))
        themesList.append(Theme(themeName: "New Year", emojisList: "🥶🐷🐽🎄❄️☃️🕰🎁👨‍👩‍👧🧣🧤", backgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1), flipedCardsColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), unflipedCardsColor: #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)))
        themesList.append(Theme(themeName: "Faces", emojisList: "😀😅😇😍😎🥰🤪🤩🤯🤗😵", backgroundColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1), flipedCardsColor: #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1), unflipedCardsColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
        themesList.append(Theme(themeName: "Animals", emojisList: "🐶🐱🐭🐹🐰🦊🐻🐼🦁🦄🐧", backgroundColor: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), flipedCardsColor: #colorLiteral(red: 0.9561221115, green: 0.5058635125, blue: 1, alpha: 1), unflipedCardsColor: #colorLiteral(red: 1, green: 0.1083210594, blue: 0.02791165737, alpha: 1)))
        return themesList
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "New Random Game":
            if let cvc = segue.destination as? ConcentrationViewController {
                let randomeThemeIndex = Int(arc4random_uniform(UInt32(gameThemes.count)))
                cvc.gameTheme = gameThemes[randomeThemeIndex]
            }
        case "New Game with Theme":
            if let cvc = segue.destination as? ConcentrationViewController {
                let chosenTheme = gameThemes[themeChooserTableView.indexPathForSelectedRow?.row ?? 0]
                cvc.gameTheme = chosenTheme
            }
        default: break
        }
    }
    
    //MARK: - TableView Delegate and DataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameThemes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "themeCell")
        let attributedThemeLable = NSAttributedString(
            string: gameThemes[indexPath.row].themeName,
            attributes:
                [NSAttributedString.Key.foregroundColor : gameThemes[indexPath.row].unflipedCardsColor ,
                 NSAttributedString.Key.font : UIFont(descriptor: UIFontDescriptor(), size: 50)]
        )
        cell?.textLabel?.attributedText = attributedThemeLable
        cell?.textLabel?.textAlignment = .center
        return cell!
    }
}
