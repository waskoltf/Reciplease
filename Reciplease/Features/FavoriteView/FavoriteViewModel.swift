// FavoriteViewModel.swift

import Foundation
import CoreData
import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    @Published var favoriteRecipes: [FavoriteRecipe] = []
    @Published var recipe: Recipe
    @Published var isFavorite: Bool = false
       
    init(recipe: Recipe) {
         self.recipe = recipe
     }
      
    func fetchFavoriteRecipes() {
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \FavoriteRecipe.id, ascending: true)]

        do {
            favoriteRecipes = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
        } catch {
            print("Error fetching favorite recipes: \(error.localizedDescription)")
        }
    }

    func deleteFavorite(offsets: IndexSet) {
        withAnimation {
            offsets.forEach { index in
                let favorite = favoriteRecipes[index]
                PersistenceController.shared.container.viewContext.delete(favorite)
            }

            do {
                try PersistenceController.shared.container.viewContext.save()
            } catch {
                print("Error saving context after deleting favorites: \(error.localizedDescription)")
            }
        }
    }
    
  
       
       
        func saveToCoreData() {
           let viewContext = PersistenceController.shared.container.viewContext
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
       
        func isRecipeFavorite() -> Bool {
           return fetchFavoriteRecipe() != nil
       }
       
        func removeFromFavorites() {
           let viewContext = PersistenceController.shared.container.viewContext
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
    
    func toggleFavorite() {
        if isFavorite {
            removeFromFavorites()
        } else {
            saveToCoreData()
        }
        isFavorite.toggle()
    }
        func fetchFavoriteRecipe() -> FavoriteRecipe? {
           let viewContext = PersistenceController.shared.container.viewContext
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
}
