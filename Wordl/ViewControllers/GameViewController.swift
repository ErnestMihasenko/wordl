//
//  GameViewController.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 30.04.22.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet weak var gameField: GameFieldView!
    @IBOutlet weak var keyboard: KeyboardView!
    
    private let keyboardManager = KeyboardManager()
    private var gameFieldManager = GameManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        keyboard.delegate = self
        keyboard.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
        gameField.updateGameField(gameFieldManager.gameField)
    }
}

extension GameViewController: KeyboardButtonDelegate {
    func handleButtonTap(_ symbol: KeyboardSymbol) {
        gameFieldManager.handleKeyboardSymbolEnter(symbol)
        
        gameField.updateGameField(gameFieldManager.gameField)
    }
}
