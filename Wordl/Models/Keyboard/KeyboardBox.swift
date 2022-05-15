//
//  KeyboardBox.swift
//  Wordl
//
//  Created by Ernest Mihasenko on 30.04.22.
//

import Foundation

struct KeyboardBox {
    let symbol: KeyboardSymbol
    let status: CheckLetterStatus?
    
    init(symbol: KeyboardSymbol,
         status: CheckLetterStatus? = nil) {
        self.symbol = symbol
        self.status = status
    }
}
