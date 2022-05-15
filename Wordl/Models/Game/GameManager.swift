//
//  GameManager.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 1.05.22.
//

import Foundation

struct GameManager {
    private var currentLetterIndexInRow = 0
    private var currentAttemptIndex = 0
    
    var gameField: [[LetterBox?]]
    
    private var lettersNumber: Int
    private var attemptsNumber: Int
    
    let resultWord = "wordl"
    
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
    
    // MARK: Check Word
    
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
            
            // TODO: Update the condition to take letters number in count
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
    
    // MARK: Delete symbol
    
    private mutating func deleteLastLetter() {
        let previousLetterIndex = currentLetterIndexInRow - 1
        
        if previousLetterIndex < 0 {
            return
        }
        
        gameField[currentAttemptIndex][previousLetterIndex] = nil
        
        currentLetterIndexInRow = previousLetterIndex
    }
    
    // MARK: Add letter
    
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
    
    // MARK: Handle game end
    
    private func handleWin() {
        print("Win")
    }
    
    private func handleLose() {
        print("Lose")
    }
}
