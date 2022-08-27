import UIKit

class SettingsViewController: UIViewController {
    
    private var gameManager = GameManager()
    
    @IBOutlet weak var lightThemeButton: UIButton!
    @IBOutlet weak var darkThemeButton: UIButton!
    @IBOutlet weak var deleteScoresButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBackGroundColor()
    }
    
    @IBAction func lightButtonHandleTap(_ sender: Any) {
        switchBackGroundColor(backGroundColor: .white)
    }
    
    @IBAction func darkButtonHandleTap(_ sender: Any) {
        switchBackGroundColor(backGroundColor: .gray)
    }
    
    @IBAction func deleteScoresHandleTap(_ sender: Any) {
        let deleteScoresAlert = UIAlertController(title: "Are you sure?", message: "All scores would be deleted permamently", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [self] _ in
            gameManager.scores = nil
        }
        deleteScoresAlert.addAction(cancelAction)
        deleteScoresAlert.addAction(deleteAction)
        present(deleteScoresAlert, animated: true)
    }
}

extension UIViewController: SettingsDelegate {
    func switchBackGroundColor(backGroundColor: backGroundColors) {
        switch backGroundColor {
        case .gray:
            view.backgroundColor = .lightGray
        case .white:
            view.backgroundColor = .white
        }
        UserDefaults.standard.set(backGroundColor.rawValue, forKey: "backGroundColor")
    }
}

extension UIViewController {
    func getBackGroundColor() {
        let backGroundColorRaw = UserDefaults.standard.integer(forKey: "backGroundColor")
        let backGroundColor = backGroundColors(rawValue: backGroundColorRaw) ?? .white
        switchBackGroundColor(backGroundColor: backGroundColor)
    }
}

enum backGroundColors: Int {
    case gray
    case white
}
