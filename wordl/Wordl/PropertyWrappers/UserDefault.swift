//
//  UserDefault.swift
//  Wordl
//
//  Created by Georgy Sabanov on 12.07.2022.
//

import Foundation

@propertyWrapper
struct UserDefault<Value: Codable> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    var wrappedValue: Value {
        get {
            guard let data = container.data(forKey: key),
                  let result = try? decoder.decode(Value.self, from: data)
            else {
                return defaultValue
            }
            
            return result
        }
        set {
            guard let data = try? encoder.encode(newValue) else {
                return
            }
            
            container.set(data, forKey: key)
        }
    }
}
