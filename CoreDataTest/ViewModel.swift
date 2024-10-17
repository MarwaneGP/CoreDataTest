import Foundation
import SwiftUI
import Combine

struct Achievement: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var isUnlocked: Bool = false
}

class AchievementsViewModel: ObservableObject {
    @Published var achievements: [Achievement] = [
        Achievement(title: "First Guess", description: "Make your first guess in the animal game."),
        Achievement(title: "Five in a Row", description: "Guess 5 animals correctly in a row."),
        Achievement(title: "Jackpot Spinner", description: "Spin the jackpot 10 times without losing.")
    ]
    
    func unlockAchievement(title: String) {
        if let index = achievements.firstIndex(where: { $0.title == title }) {
            achievements[index].isUnlocked = true
        }
    }

    func checkAchievements(for gameType: String, guessedAnimals: [String]) {
        switch gameType {
        case "AnimalGuessing":
            if guessedAnimals.count == 1 && !achievements[0].isUnlocked {
                unlockAchievement(title: "First Guess")
            }
            // Add more achievement checks as needed
        case "Jackpot":
            // Check jackpot-related achievements
            break
        default:
            break
        }
    }
}

class MainViewModel: ObservableObject {
    @Published var isValid = false
    @Published var message: String = ""
    @Published var slots: [Int] = Array(repeating: 0, count: 5)
    private let winningNumbers: Set = [77777, 12345]
    
    @Published var achievementsViewModel = AchievementsViewModel()
    
    enum Difficulty: Int {
        case easy = 3
        case medium = 4
        case hard = 5
    }
    
    @Published var difficulty: Difficulty = .easy
    let animals = ["cat", "dog", "giraffe", "rhino", "lion", "elephant", "tiger", "zebra", "bear", "fox"]
    
    @Published var cards: [Card] = []
    @Published var firstSelected: Card?
    @Published var secondSelected: Card?
    @Published var score: Int = 0
    @Published var targetAnimal: String = ""
    @Published var hint: String = ""
    @Published var guessedAnimals: [String] = []
    @Published var remainingGuesses: Int = 3
    
    init() {
        startNewGame()
    }
    
    func guess(animal: String) {
        guard !guessedAnimals.contains(animal) else { return }
        guessedAnimals.append(animal)

        // Unlock achievement when first guess is made
        achievementsViewModel.checkAchievements(for: "AnimalGuessing", guessedAnimals: guessedAnimals)

        if animal == targetAnimal {
            message = "Congratulations! You guessed the animal: \(targetAnimal)!"
            // Additional achievement checks can be added here
        } else {
            remainingGuesses -= 1
            if remainingGuesses == 0 {
                message = "Sorry, you've run out of guesses. The animal was: \(targetAnimal)."
            }
        }
    }
    
    func checkConnection(login: String, password: String) {
        let passwordTest = DataController.registeredUsers[login]
        isValid = (passwordTest == password)
    }
    
    func spin() {
        withAnimation(.easeInOut(duration: 0.9)) {
            slots = (0..<difficulty.rawValue).map { _ in Int.random(in: 0...9) }
            checkForWin()
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
    
    func startNewGame() {
        resetCards()
        targetAnimal = animals.randomElement() ?? ""
        hint = generateHint(for: targetAnimal)
        guessedAnimals = []
        remainingGuesses = 3
        message = ""
    }

    private func resetCards() {
        let shuffledAnimals = (animals + animals).shuffled()
        cards = shuffledAnimals.map { Card(name: $0) }
        for index in cards.indices {
            cards[index].isFaceUp = false
        }
        firstSelected = nil
        secondSelected = nil
        score = 0
    }
    
    func selectCard(_ card: Card) {
        guard !card.isFaceUp else { return }
        
        if firstSelected == nil {
            firstSelected = card
            cards[cards.firstIndex(where: { $0.id == card.id })!].isFaceUp = true
        } else if secondSelected == nil {
            secondSelected = card
            cards[cards.firstIndex(where: { $0.id == card.id })!].isFaceUp = true
            checkForMatch()
        }
    }
    
    private func checkForMatch() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.firstSelected?.name == self.secondSelected?.name {
                self.score += 1
                self.message = "It's a match!"
            } else {
                self.cards[self.cards.firstIndex(where: { $0.id == self.firstSelected!.id })!].isFaceUp = false
                self.cards[self.cards.firstIndex(where: { $0.id == self.secondSelected!.id })!].isFaceUp = false
                self.message = "Try again!"
            }
            self.firstSelected = nil
            self.secondSelected = nil
        }
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
}

struct Card: Identifiable {
    let id = UUID()
    var name: String
    var isFaceUp: Bool = false
}
