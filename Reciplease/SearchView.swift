//
//  SearchView.swift
//  Reciplease
//
//  Created by Riboku🗿 on 20/01/2024.
//

import SwiftUI

struct SearchView: View {
    @State private var textInput: String = ""
    var body: some View {
        
        VStack{
            Spacer()
            Text("What's in youre fridge?")
                .foregroundStyle(.black)
                .font(.custom("American Typewriter", size: 25))
            
            HStack {
                TextField("Lemon, cheese, sausages", text: $textInput)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle()) // Style de bordure arrondie
                
                Button(action: {
                    // Action à effectuer lors du clic sur le bouton "Add"
                    // Vous pouvez ajouter ici le code pour traiter la saisie ou effectuer d'autres opérations
                    print("Ajouter: \(textInput)")
                }) {
                    Text("Add")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.green)
                        .cornerRadius(5) // Coins arrondis du bouton
                }
                .padding()
            }
            .background(.brown)
            //                        .padding()
            
            Spacer()
            
            HStack {
                Text("Your ingredients: ")
                    .font(.custom("", size: 25))
                
                Spacer() // Ajoute de l'espace pour pousser le bouton à droite
                
                Button(action: {
                    // Action à effectuer lorsque le bouton est appuyé
                    // (Vous pouvez remplacer le commentaire par le code approprié)
                    print("Clear button tapped")
                }) {
                    Text("Clear")
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.gray)
                        .cornerRadius(5) // Coins arrondis du bouton
                }
            }
            .padding()
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 10) {
                HStack{
                    Text("-Apple")
                        .font(.custom("American Typewriter", size: 20))
                        .foregroundStyle(.white)
                    Spacer()
                }
                HStack{
                    Text("-Tomatoes")
                        .font(.custom("American Typewriter", size: 20))
                        .foregroundStyle(.white)
                    Spacer()
                }
                HStack{
                    Text("-Curry")
                         .font(.custom("American Typewriter", size: 20))
                        .foregroundStyle(.white)
                    Spacer()
                }
                HStack{
                    Text("-Chicken")
                        .font(.custom("American Typewriter", size: 20))
                        .foregroundStyle(.white)
                    Spacer()
                }
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)
            .padding()
            .background(.brown)
            
            Spacer()
            
            Button(action: {
                // Action à effectuer lorsque le bouton est appuyé
                // (Vous pouvez remplacer le commentaire par le code approprié)
                print("Clear button tapped")
            }) {
                Text("Search for recipe")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.4,height: UIScreen.main.bounds.width * 0.1)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.green)
                    .cornerRadius(5)
            }
            
            Spacer()
            
        }
        
        
        
    }
}

#Preview {
    SearchView()
}
