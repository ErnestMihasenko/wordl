//
//  GameDelegate.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 22.05.22.
//

import Foundation

protocol GameDelegate: AnyObject {
    func handleWin()
    func handleLose()
}
