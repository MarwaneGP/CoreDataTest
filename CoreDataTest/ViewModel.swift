//
//  ViewModel.swift
//  CoreDataTest
//
//  Created by GHALILA Marwane on 15/10/2024.
//
import Foundation
import SwiftUI
class MainViewModel: ObservableObject {  
    //comon
    @Published var message: String = ""
    
    
    //login
    @Published var isValid = false
    
    
    func checkConnection(login: String, password: String) {
        let passwordTest = DataController.registeredUsers[login]
        if let realPassword = DataController.registeredUsers[login] { // L'index existe-t-il ?
            if realPassword == password { // Le mot de passe est-il bon ?
                isValid = true
            } else {
                isValid = false
                // TODO: Messages d'erreur
            }
        } else {
            isValid = false
            // TODO: Messages d'erreurs
        }
    }
    
    // Jackpot
    @Published var slots: [Int] = Array(repeating: 0, count: 5)
    
    private let winningNumbers: Set = [77777, 12345]

    
    
    
    func spin() {
            withAnimation(.easeInOut(duration: 0.9)) {
                slots = [2, 1, 0, 1, 2] // Temporary spin values
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.slots = (0..<5).map { _ in Int.random(in: 0...9) }
                    self.checkForWin()
                }
            }
        }

    private func checkForWin() {
        let joinedSlots = slots.reduce(0) { $0 * 10 + $1 }
            
            if Set(slots).count == 1 {
                message = "You win! All slots show \(slots[0])!"
            } else if winningNumbers.contains(joinedSlots) {
                message = "Jackpot! You hit \(joinedSlots)!"
            } else {
                message = "Try again!"
            }
        }
    //Mystery
    
    let animals = ["cat", "dog", "giraffe", "rhino", "lion", "elephant", "tiger", "zebra", "bear", "fox"]
        
        @Published var targetAnimal: String = ""
        @Published var hint: String = ""
        @Published var guessedAnimals: [String] = []
        @Published var remainingGuesses: Int = 3
    
    init() {
            startNewGame()
        }
    func startNewGame() {
            targetAnimal = animals.randomElement() ?? ""
            hint = generateHint(for: targetAnimal)
            guessedAnimals = []
            remainingGuesses = 3
            message = ""
        }
    
    private func generateHint(for animal: String) -> String {
            switch animal {
            case "cat": return "I am often kept as a pet."
            case "dog": return "I am known as man's best friend."
            case "giraffe": return "I have a long neck and I love leaves."
            case "rhino": return "I have a thick skin and a horn on my nose."
            case "lion": return "I am known as the king of the jungle."
            case "elephant": return "I am the largest land animal."
            case "tiger": return "I have stripes and am a big cat."
            case "zebra": return "I have black and white stripes."
            case "bear": return "I hibernate during the winter."
            case "fox": return "I am known for being sly."
            default: return "I am an animal."
            }
        }
    
    func guess(animal: String) {
            guard !guessedAnimals.contains(animal) else { return }
            guessedAnimals.append(animal)
            
            if animal == targetAnimal {
                message = "Congratulations! You guessed the animal: \(targetAnimal)!"
            } else {
                remainingGuesses -= 1
                if remainingGuesses == 0 {
                    message = "Sorry, you've run out of guesses. The animal was: \(targetAnimal)."
                }
            }
        }
    
}

