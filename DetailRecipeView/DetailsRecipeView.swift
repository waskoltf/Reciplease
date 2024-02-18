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
                    // Utilisation de isFavorite pour afficher une étoile pleine ou vide
                                       Button(action: {
                                           if isFavorite {
                                               removeFromFavorites()
                                           } else {
                                               saveToCoreData()
                                           }
                                           isFavorite.toggle() // Bascule de l'état isFavorite
                                       }) {
                                           Image(systemName: isFavorite ? "star.fill" : "star")
                                                         .resizable()
                                                         .frame(width: 25, height: 25)
                                                         .foregroundColor(isFavorite ? .yellow : .gray)
                                       }                }
                .frame(width: UIScreen.main.bounds.width * 0.85)
            
                Spacer()
                
                Text("Nom: \(recipe.label)")
                    .font(.custom("American Typewriter", size: 20))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                
                Text("Temps de préparation: \(formattedTime)")
                    .fontWeight(.semibold)
                
                // Afficher les ingrédients
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
                //            Text("Label: \(recipe.image)")
                HStack {
                    // MARK: - IMAGE
                    // Utilisez une URL pour charger l'image depuis le lien fourni dans les données de recette
                    
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
//            .frame(width: UIScreen.main.bounds.width * 0.85, height: UIScreen.main.bounds.height * 0.8)
//            .background(.red)
        }
        .onAppear {
            // Vérifier si la recette est dans les favoris lors de l'apparition de la vue
            isFavorite = isRecipeFavorite()
        }

       
    }
    func saveToCoreData() {
        // Vérifiez d'abord si la recette existe déjà en favori
        if fetchFavoriteRecipe() == nil {
            // Si la recette n'existe pas, ajoutez-la à CoreData
            let favoriteRecipe = FavoriteRecipe(context: viewContext)
            favoriteRecipe.id = UUID()
            favoriteRecipe.label = recipe.label
            favoriteRecipe.image = recipe.image
            favoriteRecipe.ingredients = recipe.ingredients.map { $0.text }.joined(separator: ", ")
            favoriteRecipe.url = recipe.url
            favoriteRecipe.totalTime = recipe.totalTime

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        } else {
            // Si la recette existe déjà en favori, vous pouvez gérer cette situation comme vous le souhaitez.
            // Vous pouvez afficher une alerte à l'utilisateur ou effectuer une autre action.
            print("La recette est déjà en favori.")
        }
    }
    
    func toggleFavorite() {
        if isFavorite {
            removeFromFavorites()
        } else {
            saveToCoreData()
        }
        isFavorite.toggle()
    }

    func isRecipeFavorite() -> Bool {
        return fetchFavoriteRecipe() != nil
    }


    
    func removeFromFavorites() {
           // Implémentez le code pour supprimer la recette des favoris
           // Utilisez une requête fetch pour trouver la recette dans CoreData
           // Et ensuite la supprimer du contexte géré
           if let existingFavorite = fetchFavoriteRecipe() {
               viewContext.delete(existingFavorite)
               do {
                   try viewContext.save()
               } catch {
                   let nsError = error as NSError
                   fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
               }
           }
       }

       func fetchFavoriteRecipe() -> FavoriteRecipe? {
           let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "label == %@", recipe.label)
           do {
               let favorites = try viewContext.fetch(fetchRequest)
               return favorites.first
           } catch {
               let nsError = error as NSError
               fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
