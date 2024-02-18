//
//  SearchRecipeService.swift
//  Reciplease
//
//  Created by Riboku🎯 on 18/02/2024.
//

import Alamofire
import Foundation

class RecipeService {
    
    private let apiKey = "ccaf6b0bb75784638446390ac14ea535"
     var recipe: Recipe?
    func searchRecipes(query: String, completion: @escaping (Result<[Recipe], Error>) -> Void) {
        let endpoint = "https://api.edamam.com/api/recipes/v2"
        
        let parameters: [String: Any] = [
            "q": query,
            "app_id": "05754b8c",
            "app_key": apiKey,
            "type": "public"
        ]

        AF.request(endpoint, method: .get, parameters: parameters).responseDecodable(of: EdamamResponse.self) { response in
            switch response.result {
            case .success(let edamamResponse):
                let recipes = edamamResponse.hits.map { $0.recipe }
                completion(.success(recipes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

        func getRecipe(completion: @escaping () -> Void) {
            let apiKey = "ccaf6b0bb75784638446390ac14ea535"
            let appId = "05754b8c"
            let recipeUrl = "https://api.edamam.com/search?q=YOUR_RECIPE_NAME&app_id=\(appId)&app_key=\(apiKey)"

            AF.request(recipeUrl).responseDecodable(of: EdamamResponse.self) { response in
                switch response.result {
                case .success(let edamamResponse):
                    print("ahahahahahah")
                    print("ahahahahahah")
                    print("ahahahahahah")
                    print("ahahahahahah")
                    print("ahahahahahah")
                    print("ahahahahahah")
//                    let recipes = edamamResponse.hits.first?.recipe
                    self.recipe = edamamResponse.hits.first?.recipe
                case .failure(let error):
                    print("Error: \(error)")
                }
                completion()
            }
        }
//    }


}



