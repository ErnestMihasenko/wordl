//
//  MenuViewController.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 14.05.22.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var scoresButton: UIButton!
    
    @IBOutlet weak var settingsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.titleLabel?.font = UIFont(name: "Marker Felt Thin", size: 50)
        
    }
    
    
    @IBAction func startButtonHandleTap(_ sender: Any) {
        
        startButton.titleLabel!.font = UIFont(name: "Marker Felt Thin", size: 50)
        
        guard let gameViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        
        navigationController?.pushViewController(gameViewController, animated: true)
        
    }
    
    @IBAction func scoresButtonHandleTap(_ sender: Any) {
        
        guard let scoresViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "HighScoresViewController") as? HighScoresViewController else { return }
        
        navigationController?.pushViewController(scoresViewController, animated: true)
        
    }
    
    
    @IBAction func settingsButtonHandleTap(_ sender: Any) {
        
        guard let settingsViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "SettingsViewController") as? SettingsViewController else { return }
        
        navigationController?.pushViewController(settingsViewController, animated: true)
        
    }
    
}
