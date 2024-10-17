//
//  MainView.swift
//  CoreDataTest
//
//  Created by GHALILA Marwane on 15/10/2024.
//



// Projet SwiftUI

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    
    @State var login: String = ""
    @State var password: String = ""
    @State var alert: Bool = false
    @State private var isPressed = false 
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.black, Color(white: 0.2)]),
                               startPoint: .top,
                               endPoint: .bottom)
                .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    if !viewModel.isValid {
                        VStack {
                            Text("Connectez-vous")
                                .font(.system(size: 24, weight: .bold))
                                .padding(.bottom, 80)
                                .foregroundColor(.white)

                            
                            TextField("Login", text: $login)
                                .frame(width: 246, height: 44)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            TextField("Password", text: $password)
                                .frame(width: 246, height: 44)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            
                            
                            Button(action: {
                                withAnimation {
                                    isPressed.toggle()
                                }
                                viewModel.checkConnection(login: login, password: password)
                            }) {
                                Text("Check")
                                    .foregroundColor(.white)
                                    .frame(width: 246, height: 44)
                                    .background(isPressed ? Color.gray.opacity(0.7) : Color.gray)
                                    .cornerRadius(8)
                                    .scaleEffect(isPressed ? 0.95 : 1.0)
                                    .animation(.easeInOut(duration: 0.1), value: isPressed)
                            }
                            .onChange(of: isPressed) { newValue in
                                
                                if newValue {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        isPressed = false
                                    }
                                }
                            }
                        }
                        .padding()
                    } else {
                        Text("Login Complete !")
                            .foregroundColor(.white)
                            .font(.largeTitle)
                            .padding(.bottom, 25)
                        NavigationLink(destination: MenuAppsView()) {
                            Text("Menu")
                                .foregroundColor(.white)
                                .frame(width: 246, height: 44)
                                .background(isPressed ? Color.gray.opacity(0.7) : Color.gray)
                                .cornerRadius(8)
                                .scaleEffect(isPressed ? 0.95 : 1.0)
                                .animation(.easeInOut(duration: 0.1), value: isPressed)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainView()
}
