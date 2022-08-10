//
//  LetterFieldView.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 24.04.22.
//

import UIKit

class LetterBoxView: UIView {
    
    @IBOutlet var characterView: UIView!
    @IBOutlet weak var characterLabel: UILabel!
    
    private var letterBox: LetterBox?
    
    init(letterBox: LetterBox?) {
        self.letterBox = letterBox
        
        super.init(frame: .zero)
        
        setUpView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
    }
    
    private func setUpView() {
        createXib()
        createBorder()
        updateView(letterBox: letterBox)
    }
    
    private func createXib() {
        Bundle.main.loadNibNamed("LetterBoxView", owner: self, options: nil)
        
        addSubview(characterView)
        
        characterView.frame = bounds
        characterView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    private func createBorder() {
        characterView.layer.borderColor = UIColor.blue.cgColor
        characterView.layer.borderWidth = 2
    }
    
    func updateLetterBox(letterBox: LetterBox?) {
        self.letterBox = letterBox
        
        updateView(letterBox: letterBox)
    }
    
    private func updateView(letterBox: LetterBox?) {
        updateLabel(letter: letterBox?.letter)
        updateBackground(status: letterBox?.status)
    }
    
    private func updateLabel(letter: String?) {
        characterLabel.text = letter?.uppercased()
    }
    
    private func updateBackground(status: CheckLetterStatus?) {
        switch status {
        case .wrongLetter:
            characterView.backgroundColor = .gray
            
        case .wrongPlace:
            characterView.backgroundColor = .yellow
            
        case .correctLetter:
            characterView.backgroundColor = .green
            
        default:
            characterView.backgroundColor = .clear
        }
    }
}
