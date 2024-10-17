//
//  MenuAppsView.swift
//  CoreDataTest
//
//  Created by GHALILA Marwane on 15/10/2024.
//

import SwiftUI

struct MenuAppsView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(white: 0.2)]),startPoint: .top,endPoint: .bottom)
                .ignoresSafeArea()
                VStack {
                    ScrollView {
                        Text("Menu des applications")
                            .font(.system(size: 24, weight: .bold))
                            .padding(.bottom, 20)
                            .foregroundColor(.white)
                            .tint(.white)

//                        Image("pic")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 100, height: 100)
//                            .padding()

                        ForEach(availableApps.allCases, id: \.self) { nameApp in
                            NavigationLink(destination: AppDetailView(appName: nameApp.rawValue)) {
                                IconView(image: Image("cloud"), name: nameApp.rawValue)
                            }
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    MenuAppsView()
}
