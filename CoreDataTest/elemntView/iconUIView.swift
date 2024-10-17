//
//  iconUIView.swift
//  CoreDataTest
//
//  Created by GHALILA Marwane on 16/10/2024.
//
import SwiftUI

struct IconView: View {
    
    let image: Image
    let name: String
    
    var body: some View {
        VStack {
            Text(name)
                .foregroundColor(.white)
            image
                .resizable()
                .frame(width: 350, height: 200)
                
                
            
        }
        .frame(width: 220, height: 260)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding()
        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color(white: 0.2)]),startPoint: .top,endPoint: .bottom))
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

#Preview {
    IconView(image: Image("Mystery"), name: "Jeu")
}
