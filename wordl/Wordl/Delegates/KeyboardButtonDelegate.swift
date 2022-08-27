//
//  KeyboardButtonDelegate.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 30.04.22.
//

import Foundation

protocol KeyboardButtonDelegate: AnyObject {
    func handleButtonTap(_ symbol: KeyboardSymbol)
}
