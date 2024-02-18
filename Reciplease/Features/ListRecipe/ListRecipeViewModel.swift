//
//  SearchRecipeViewModel.swift
//  Reciplease
//
//  Created by Riboku🎯 on 18/02/2024.
//

import Foundation
import SwiftUI

class ListRecipeViewModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    private let service = RecipeService()

    func searchRecipes(query: String) {
        service.searchRecipes(query: query, completion: { result in
            switch result {
            case .success(let recipes):
                self.recipes = recipes
            case .failure(let error):
                print("Erreur de requête API: \(error.localizedDescription)")
            }
        })
    }
}
