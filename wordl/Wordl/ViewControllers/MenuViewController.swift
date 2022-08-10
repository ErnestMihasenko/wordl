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
        
        scoresButton.titleLabel?.font = UIFont(name: "Marker Felt Thin", size: 50)
        settingsButton.titleLabel?.font = UIFont(name: "Marker Felt Thin", size: 50)
        getBackGroundColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getBackGroundColor()
    }
    
    @IBAction func startButtonHandleTap(_ sender: Any) {
        
        startButton.titleLabel!.font = UIFont(name: "Marker Felt Thin", size: 50)
        
        let gameViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "GameViewController")
        
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @IBAction func scoresButtonHandleTap(_ sender: Any) {
        
        let scoresViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "HighScoresViewController")
        
        navigationController?.pushViewController(scoresViewController, animated: true)
    }
    
    @IBAction func settingsButtonHandleTap(_ sender: Any) {
        
        let settingsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "SettingsViewController")
        
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
}
