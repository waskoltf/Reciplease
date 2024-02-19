
import Foundation
import CoreData
import SwiftUI

class FavoriteViewModel: ObservableObject {
    @Environment(\.managedObjectContext) private var viewContext
    @Published var favoriteRecipes: [FavoriteRecipe] = []
    @Published var isFavorite: Bool = false

    // Retirer l'initialisation de recipe ici

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
            offsets.sorted(by: >).forEach { index in
                guard index < favoriteRecipes.count else {
                    print("Index out of range: \(index)")
                    return
                }

                let favorite = favoriteRecipes[index]
                PersistenceController.shared.container.viewContext.delete(favorite)
            }

            do {
                try PersistenceController.shared.container.viewContext.save()
                // Mettre à jour favoriteRecipes après la suppression
                fetchFavoriteRecipes()
            } catch {
                print("Error saving context after deleting favorites: \(error.localizedDescription)")
            }
        }
    }




    // Supprimer l'init(recipe: Recipe) ici

    func saveToCoreData(recipe: Recipe) {
        let viewContext = PersistenceController.shared.container.viewContext

        // Vérifiez d'abord si la recette existe déjà en favori
        if !isRecipeFavorite(recipe: recipe) {
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
                // Mettre à jour favoriteRecipes après l'ajout
                fetchFavoriteRecipes()
            } catch {
                print("Error saving context after adding favorite: \(error.localizedDescription)")
            }
        } else {
            // Si la recette existe déjà en favori, ne rien faire
            print("La recette est déjà en favori.")
        }
    }







    func isRecipeFavorite(recipe: Recipe) -> Bool { // Ajouter recipe en paramètre
        return fetchFavoriteRecipe(recipe: recipe) != nil // Passer la recette en paramètre
    }

    func removeFromFavorites(recipe: Recipe) { // Ajouter recipe en paramètre
        let viewContext = PersistenceController.shared.container.viewContext
        // Implémentez le code pour supprimer la recette des favoris
        // Utilisez une requête fetch pour trouver la recette dans CoreData
        // Et ensuite la supprimer du contexte géré
        if let existingFavorite = fetchFavoriteRecipe(recipe: recipe) { // Passer la recette en paramètre
            viewContext.delete(existingFavorite)
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    func toggleFavorite(recipe: Recipe) -> Bool {
        if isRecipeFavorite(recipe: recipe) {
            removeFromFavorites(recipe: recipe)
            return false
        } else {
            saveToCoreData(recipe: recipe)
            return true
        }
    }




    func fetchFavoriteRecipe(recipe: Recipe) -> FavoriteRecipe? {
        let viewContext = PersistenceController.shared.container.viewContext
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "label == %@ AND url == %@", recipe.label, recipe.url)
        do {
            let favorites = try viewContext.fetch(fetchRequest)
            print("Nombre de recettes favorites récupérées pour \(recipe.label) : \(favorites.count)")
            return favorites.first
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }


}
