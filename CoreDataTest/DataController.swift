//
//  DataController.swift
//  CoreDataTest
//
//  Created by GHALILA Marwane on 16/10/2024.
//
import SwiftUI
import Foundation
class DataController {
    static var registeredUsers: [String: String] = [
        "Jean": "12345",
        "Anne": "54321"
    ]
    
    let tableau = [1, 2, 23]
    
    
    
    func checkDico(dico: [String:EleveTest]) {
        for element in dico {
            print("\(element.key) s'appelle \(element.value.name) et a \(element.value.age)")
        }
    }
}

struct EleveTest {
    var name: String
    var age: Int
}
