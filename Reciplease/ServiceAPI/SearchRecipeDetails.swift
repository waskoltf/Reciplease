//
//  SearchRecipeDetails.swift
//  SampleCoreData
//
//  Created by Riboku🎯 on 22/01/2024.
//

import Foundation
import Alamofire

class SearchRecipeDetails: ObservableObject {
    @Published var recipe: Recipe?

    func getRecipe(completion: @escaping () -> Void) {
        let apiKey = "ccaf6b0bb75784638446390ac14ea535"
        let appId = "05754b8c"
        let recipeUrl = "https://api.edamam.com/search?q=YOUR_RECIPE_NAME&app_id=\(appId)&app_key=\(apiKey)"

        AF.request(recipeUrl).responseDecodable(of: EdamamResponse.self) { response in
            switch response.result {
            case .success(let edamamResponse):
                self.recipe = edamamResponse.hits.first?.recipe
            case .failure(let error):
                print("Error: \(error)")
            }
            completion()
        }
    }
}

