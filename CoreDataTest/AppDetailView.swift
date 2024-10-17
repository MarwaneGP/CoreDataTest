//
//  AppDetailView.swift
//  CoreDataTest
//
//  Created by etudiant on 17/10/2024.
//
import SwiftUI

struct AppDetailView: View {
    enum AvailableApps: String, CaseIterable {
        case mystery = "mystery"
        case jackpot = "jackpot"
        case autre = "autre"
    }
    //Jackpot
    @StateObject private var viewModel = MainViewModel()
    
    
    //mystery
    
    
    
    let appName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(white: 0.2)]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Details for \(appName)")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                    
                    switch AvailableApps(rawValue: appName) {
                    case .mystery:
                        Text("This is the mystery App. Here you can check the mysteries.")
                            .foregroundColor(.white)
                            .padding()
                        VStack(spacing: 20) {
                            Text("Guess the Animal!")
                                .font(.largeTitle)
                                .padding()
                                .foregroundColor(.white)
                            Text("Hint: \(viewModel.hint)")
                                .font(.headline)
                                .padding()
                                .foregroundColor(.white)
                            
                            
                            Text("Remaining Guesses: \(viewModel.remainingGuesses)")
                                .font(.subheadline)
                                .padding()
                                .foregroundColor(.white)
                            
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 10) {
                                    ForEach(viewModel.animals, id: \.self) { animal in
                                        if !viewModel.guessedAnimals.contains(animal) {
                                            Button(action: {
                                                viewModel.guess(animal: animal)
                                            }) {
                                                Text(animal.capitalized)
                                                    .font(.title)
                                                    .padding()
                                                    .background(Color.blue)
                                                    .foregroundColor(.white)
                                                    .cornerRadius(10)
                                            }
                                            .disabled(viewModel.message != "")
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            
                            if !viewModel.message.isEmpty {
                                Text(viewModel.message)
                                    .font(.title2)
                                    .foregroundColor(.green)
                                    .padding()
                                    .foregroundColor(.white)
                            }
                            
                            
                            Button(action: {
                                viewModel.startNewGame()
                            }) {
                                Text("Start New Game")
                                    .font(.title)
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .disabled(viewModel.message == "")
                        }
                        .padding()
                        .navigationTitle("Animal Guessing Game")
                        
                    case .jackpot:
                        VStack {
                            Text("Jackpot Game")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .padding()
                            
                            HStack {
                                ForEach(viewModel.slots.indices, id: \.self) { index in
                                    Text("\(viewModel.slots[index])")
                                        .font(.system(size: 40))
                                        .frame(width: 50, height: 50)
                                        .background(Color.black)
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                        .scaleEffect(viewModel.slots[index] == 0 ? 1.2 : 1.0)
                                        .animation(.easeInOut(duration: 0.5), value: viewModel.slots[index])
                                }
                            }
                            .padding()
                            
                            Text(viewModel.message)
                                .font(.title)
                                .foregroundColor(.green)
                                .padding()
                            
                            Button(action: {
                                viewModel.spin() // Call the spin method from the ViewModel
                            }) {
                                Text("Spin!")
                                    .font(.title)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding()
                        }
                        .padding()
                        
                    case .autre:
                        Text("This is the autre App. Perform your other things here.")
                            .foregroundColor(.white)
                            .padding()
                        
                    case .none:
                        Text("App not found.")
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
        }
    }
}








