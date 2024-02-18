//
//  DetailsRecipeViewModel.swift
//  Reciplease
//
//  Created by Riboku🎯 on 18/02/2024.
//


import Foundation

class DetailsRecipeViewModel: ObservableObject {
    
    @Published var recipe: Recipe?
    
         let service = RecipeService()
    
    func fetchRecipe() {
        service.getRecipe { [weak self] in
            guard let self = self else { return }
            self.recipe = self.service.recipe
        }
    }
    
}
