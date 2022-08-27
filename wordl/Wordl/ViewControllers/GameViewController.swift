import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var gameField: GameFieldView!
    @IBOutlet weak var keyboard: KeyboardView!
    
    private let keyboardManager = KeyboardManager()
    private var gameFieldManager = GameManager()
    private var lastName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBackGroundColor()
        
        keyboard.delegate = self
        gameFieldManager.delegate = self
        keyboard.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
        gameField.updateGameField(gameFieldManager.gameField)
        lastName = gameFieldManager.lastName
    }
}

extension GameViewController: KeyboardButtonDelegate {
    func handleButtonTap(_ symbol: KeyboardSymbol) {
        gameFieldManager.handleKeyboardSymbolEnter(symbol)
        
        gameField.updateGameField(gameFieldManager.gameField)
    }
}

extension GameViewController: GameDelegate {
    
    func handleWin() {
        showWinAlert(title: "Win!", message: "Congratulations", hasWin: true)
    }
    
    func handleLose() {
        showWinAlert(title: "Lost :(", message: "Try again!", hasWin: false)
    }
    
    private func showWinAlert(title: String, message: String, hasWin: Bool) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        var nameTextField: UITextField?
        
        if hasWin == true {
            alertController.addTextField { [weak self] nameField in
                nameField.text = self?.lastName
                nameField.placeholder = "Your name"
                nameTextField = nameField
            }
        }
        
        let restartAction = UIAlertAction(title: "Restart", style: .default) { [weak self] _ in
            print("Restart")
            self?.gameFieldManager.saveGameResult(name: nameTextField?.text ?? "Username")
            self?.restartGame()
        }
        
        let goBackToMenuAction = UIAlertAction(title: "Main menu", style: .cancel) { [weak self] _ in
            self?.gameFieldManager.saveGameResult(name: nameTextField?.text ?? "Username")
            self?.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(goBackToMenuAction)
        
        present(alertController, animated: true)
    }
    
    private func restartGame() {
        
        gameFieldManager = GameManager()
        gameFieldManager.delegate = self
        
        gameField.updateGameField(gameFieldManager.gameField)
    }
}
