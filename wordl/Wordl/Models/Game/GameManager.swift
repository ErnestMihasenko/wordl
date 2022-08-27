//
//  GameManager.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 1.05.22.
//

import Foundation

struct GameManager {
    private var currentLetterIndexInRow = 0
    var currentAttemptIndex = 0
    
    var gameField: [[LetterBox?]]
    
    private var lettersNumber: Int
    var attemptsNumber: Int
    
    private(set) lazy var resultWord = getRandomWord()
    
    @UserDefault(key: "scores", defaultValue: [])
    var scores: [GameResult]?
    
    weak var delegate: GameDelegate?
    
    var lastName: String? {
        guard let scores = scores else {
            return nil
        }
        
        return scores.last?.playersName
    }
    
    init(lettersNumber: Int = 5,
         attemptsNumber: Int = 6) {
        let row: [LetterBox?] = Array(repeating: nil, count: lettersNumber)
        
        self.gameField = Array(repeating: row, count: attemptsNumber)
        
        self.lettersNumber = lettersNumber
        self.attemptsNumber = attemptsNumber
    }
    
    mutating func handleKeyboardSymbolEnter(_ symbol: KeyboardSymbol) {
        switch symbol {
        case .enter:
            checkWord()
            
        case .delete:
            deleteLastLetter()
            
        case .character(let letter):
            addLetter(letter)
        }
    }
    
    private mutating func checkWord() {
        if currentLetterIndexInRow < lettersNumber ||
            currentAttemptIndex >= attemptsNumber {
            return
        }
        
        guard let currentWord = getCurrentWord() else {
            return
        }
        
        let resultWordArray = Array(resultWord)
        
        for (index, letter) in currentWord.enumerated() {
            if letter == resultWordArray[index] {
                gameField[currentAttemptIndex][index]?.status = .correctLetter
                
                continue
            }
            
            if resultWord.contains(letter) {
                gameField[currentAttemptIndex][index]?.status = .wrongPlace
                
                continue
            }
            
            gameField[currentAttemptIndex][index]?.status = .wrongLetter
        }
        
        if currentWord == resultWord {
            handleWin()
            
            return
        }
        
        currentAttemptIndex += 1
        currentLetterIndexInRow = 0
        
        if currentAttemptIndex == attemptsNumber {
            handleLose()
        }
    }
    
    private func getCurrentWord() -> String? {
        let wordRow = gameField[currentAttemptIndex]
        
        var word = ""
        
        for letterBox in wordRow {
            guard let letter = letterBox?.letter else {
                return nil
            }
            word += letter
        }
        return word
    }
    
    private mutating func deleteLastLetter() {
        let previousLetterIndex = currentLetterIndexInRow - 1
        
        if previousLetterIndex < 0 {
            return
        }
        
        gameField[currentAttemptIndex][previousLetterIndex] = nil
        
        currentLetterIndexInRow = previousLetterIndex
    }
    
    private mutating func addLetter(_ letter: String) {
        if currentLetterIndexInRow >= lettersNumber {
            return
        }
        
        if currentAttemptIndex < attemptsNumber {
            gameField[currentAttemptIndex][currentLetterIndexInRow] =
            LetterBox(letter: letter, status: nil)
        }
        
        currentLetterIndexInRow += 1
    }
    
    private mutating func handleWin() {
        gameTime = Date().timeIntervalSince(startTime)
        delegate?.handleWin()
    }
    
    private mutating func handleLose() {
        gameTime = Date().timeIntervalSince(startTime)
        delegate?.handleLose()
    }
    
    func getRandomWord() -> String {
        guard let path = Bundle.main.path(forResource: "AllowedWords", ofType: "txt"),
              let allowedWordsArray = try? String(
                contentsOfFile: path,
                encoding: String.Encoding.utf8
              ).split(separator: "\n"),
              !allowedWordsArray.isEmpty
        else {
            return "Wordl"
        }
        
        let allowedWords = Set(allowedWordsArray)
        let randomWord = allowedWords.randomElement()
        let word = String(randomWord ?? "Wordl")
        print(word)
        return word
    }
    
    mutating func saveGameResult(name: String) {
        let time = gameTime
        
        let result = GameResult(playersName: name, score: currentAttemptIndex + 1, time: Int(time))
        scores?.append(result)
    }
    
    var startTime = Date()
    var gameTime: TimeInterval = 0
}
