//
//  DetailsRecipeView.swift
//  Reciplease
//
//  Created by Riboku🎯 on 23/01/2024.
//

import SwiftUI
import CoreData

struct DetailsRecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var recipe: Recipe
    @StateObject private var favoriteViewModel = FavoriteViewModel() // Créez une instance de votre ViewModel

    @State private var isFavorite: Bool = false
    
    var body: some View {
        ScrollView{
            VStack (spacing:20){
                Spacer()
                HStack{
                    Text("Recipe Details")
                        .font(.custom("American Typewriter", size: 35))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                    Button(action: {
                        isFavorite = favoriteViewModel.toggleFavorite(recipe: recipe)
                    }) {
                        Image(systemName: isFavorite ? "star.fill" : "star")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(isFavorite ? .yellow : .gray)
                    }

                }
                .frame(width: UIScreen.main.bounds.width * 0.85)
                Spacer()
                Text("Nom: \(recipe.label)")
                    .font(.custom("American Typewriter", size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                Text("Temps de préparation: \(formattedTime)")
                    .fontWeight(.semibold)
                if !recipe.ingredients.isEmpty {
                    Text("Ingrédients:")
                        .multilineTextAlignment(.leading)
                        .font(.custom("American Typewriter", size: 25))
                        .bold()
                    ForEach(recipe.ingredients, id: \.text) { ingredient in
                        VStack{
                            Text("- \(ingredient.text)")
                                .font(.custom("American Typewriter", size: 20))
                                .frame(width: UIScreen.main.bounds.width * 0.7)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                        }
                        .background(Color("YellowSecondColor"))
                    }
                } else {
                    Text("Aucun ingrédient disponible")
                }
                HStack {
                    if let imageURL = URL(string: recipe.image) {
                        AsyncImage(url: imageURL) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            @unknown default:
                                fatalError()
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.2)
                .background(.white)
                .clipped()
            }
        }
        .onAppear {
            // Chargez les recettes favorites lors de l'apparition de la vue
            favoriteViewModel.fetchFavoriteRecipes()
            // Vérifiez si la recette actuelle est dans les favoris
            isFavorite = favoriteViewModel.isRecipeFavorite(recipe: recipe)
        }
    }


    var formattedTime: String {
          if recipe.totalTime > 0 {
              let hours = Int(recipe.totalTime) / 60
              let minutes = Int(recipe.totalTime.truncatingRemainder(dividingBy: 60))
              if hours > 0 {
                  if minutes > 0 {
                      return "\(hours)h \(minutes)m"
                  } else {
                      return "\(hours)h"
                  }
              } else {
                  return "\(minutes)m"
              }
          } else {
              return "Durée indéterminée"
          }
      }
}

//#Preview {
//    DetailsRecipeView(recipe: <#Recipe#>)
//}
