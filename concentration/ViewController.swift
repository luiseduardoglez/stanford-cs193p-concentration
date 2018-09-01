//
//  ViewController.swift
//  concentration
//
//  Created by Luis Eduardo Gonzalez on 2018-03-22.
//  Copyright © 2018 Luis Eduardo Glez. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{

    lazy var game: Concentration = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    var themes: Dictionary<String, Array<String>> = [
        "halloween": ["🦇", "😱", "🙀", "😈", "🎃" , "👻", "🍭", "🍬", "🍎"],
        "animals": ["🐶", "🐱", "🐭", "🦊", "🐼" , "🦁", "🐮", "🐷", "🐸"],
        "faces": ["😀", "😂", "😇", "😍", "😘" , "😜", "😶", "🤔", "😢"],
        "food": ["🍎", "🍐", "🍋", "🍌", "🍓" , "🍒", "🍍", "🍇", "🍉"],
        "flags": ["🇨🇺", "🇩🇪", "🇺🇸", "🇬🇧", "🇫🇷" , "🇪🇸", "🇨🇦", "🇯🇵", "🇲🇱"],
        "tech": ["⌚️", "📱", "💻", "🖥", "🖨" , "💾", "📀", "🖱", "⌨️"]]
    
    var emojiChoices: Array<String> = []
    
    fileprivate func selectThemeRandomly() {
        let themeNames = Array(themes.keys)
        let randomThemeIndex = Int(arc4random_uniform(UInt32(themes.count)))
        emojiChoices = themes[themeNames[randomThemeIndex]]!
    }
    
    fileprivate func startNewGame() {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        selectThemeRandomly()
        updateViewFromModel()
        
    }
    
    @IBAction func newGame(_ sender: Any) {
        startNewGame()
    }
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0): #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    override func viewDidLoad() {
        startNewGame()
    }
    
}

