//
//  File.swift
//  CoreDataTest
//
//  Created by GHALILA Marwane on 16/10/2024.
//

import Foundation
import SwiftUI

class AppParameters {
    static let backgroundColor: Color = .orange
    static var isValid: Bool = true
    
    
}

enum availableApps: String {
    static let allCases: [availableApps] = [.mystery,.jackpot,.autre]
    
    case mystery
    case jackpot
    case autre
    
    var image: Image {
        switch self {
        case .mystery:
            return Image(self.rawValue)
        case .jackpot:
            return Image(self.rawValue)
        case .autre:
            return Image(self.rawValue)
        }
    }
    var title: String {
        switch self {
            
            
        case .mystery:
            return "mystery"
        case .jackpot:
            return "jackpot"
        case .autre:
            return "Autre"
        }
    }
}
