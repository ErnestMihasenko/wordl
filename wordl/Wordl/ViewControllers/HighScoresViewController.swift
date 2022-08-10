//
//  HighScoresViewController.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 14.05.22.
//

import UIKit

class HighScoresViewController: UIViewController {
    
    @IBOutlet weak var scoresLabel: UILabel!
    
    @IBOutlet weak var scoresTableView: UITableView!
    
    private var gameManager = GameManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        getBackGroundColor()
        // Do any additional setup after loading the view.
    }
}

extension HighScoresViewController: UITableViewDelegate {
        
    func setUpTableView() {
        scoresTableView.delegate = self
        scoresTableView.dataSource = self
        scoresTableView.register(UINib(nibName: "ScoreTableViewCell", bundle: nil), forCellReuseIdentifier: ScoreTableViewCell.id)
    }
}

extension HighScoresViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameManager.scores?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let score = gameManager.scores?[indexPath.row] else { return UITableViewCell() }
        
        return getScore(tableView, score: score, indexPath: indexPath)
    }
    
    private func getScore(_ tableView: UITableView, score: GameResult, indexPath: IndexPath) -> UITableViewCell {
        guard let scoreCell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.id, for: indexPath) as? ScoreTableViewCell else {
            return UITableViewCell()
        }
        
        scoreCell.getScore(score: score)
        
        return scoreCell
    }
}



