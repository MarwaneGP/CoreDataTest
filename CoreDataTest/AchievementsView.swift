//
//  AchievementsView.swift
//  CoreDataTest
//
//  Created by etudiant on 17/10/2024.
//

import SwiftUI

struct AchievementsView: View {
    @ObservedObject var achievementsViewModel: AchievementsViewModel

    var body: some View {
        NavigationView {
            List(achievementsViewModel.achievements) { achievement in
                HStack {
                    Text(achievement.title)
                        .font(.headline)
                    Spacer()
                    if achievement.isUnlocked {
                        Image(systemName: "checkmark")
                            .foregroundColor(.green)
                    }
                }
                .padding()
                Text(achievement.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .navigationTitle("Achievements")
        }
    }
}
