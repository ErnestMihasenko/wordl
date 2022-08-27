//
//  GameResult.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 23.05.22.
//

import Foundation

struct GameResult: Codable {
    let playersName: String
    let score: Int
    let time: Int
}
