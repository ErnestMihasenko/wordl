//
//  ScoreCellTableViewCell.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 10.07.22.
//

import UIKit

class ScoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playersName: UILabel!
    
    @IBOutlet weak var attemptsNumber: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    private var gameManager = GameManager()
    
    static let id = "ScoreCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func getScore(score: GameResult) {
        self.playersName?.text = score.playersName
        self.attemptsNumber?.text = String(score.score)
        self.time?.text = String(score.time)
    }
    
}
