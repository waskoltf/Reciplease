//
//  SearchRecipe.swift
//  SampleCoreData
//
//  Created by Riboku🎯 on 22/01/2024.
//

import Foundation
import Alamofire

class SearchRecipe: ObservableObject {
    @Published var recipes: [Recipe] = []
    
    func searchRecipes(query: String) {
        let apiKey = "ccaf6b0bb75784638446390ac14ea535"
        let endpoint = "https://api.edamam.com/api/recipes/v2"
        
        let parameters: [String: Any] = [
            "q": query,
            "app_id": "05754b8c",
            "app_key": apiKey,
            "type": "public" // Add any required parameters here
        ]


        AF.request(endpoint, method: .get, parameters: parameters).responseDecodable(of: EdamamResponse.self) { response in
//            print(response)
            debugPrint(response)
            switch response.result {
            case .success(let edamamResponse):
                DispatchQueue.main.async {
                    self.recipes = edamamResponse.hits.map { $0.recipe }
                }
            case .failure(let error):
                print("Erreur de requête API: \(error.localizedDescription)")
            }
        }
    }
}



struct EdamamResponse: Decodable {
    var hits: [Hit]

    private enum CodingKeys: String, CodingKey {
        case hits = "hits"
    }
}

struct Hit: Decodable {
    let recipe: Recipe
}

struct Recipe: Identifiable, Decodable {
    var id = UUID()
    let label: String
    let image: String
    let ingredients: [Ingredient]
    let url: String
    let totalTime: Double  // Update this line

    private enum CodingKeys: String, CodingKey {
        case label
        case image
        case ingredients
        case url
        case totalTime = "totalTime"  // Add this line
    }
}

struct Ingredient: Decodable {
    let text: String
    let food: String
}

struct Links: Decodable {
    let next: Next?
}

struct Next: Decodable {
    let href: String?
}


//struct Recipe: Identifiable, Decodable {
//    var id: UUID { UUID() }
//    var uri: String
//    var label: String
//    var image : String
//    var time: String?
////    var ingredients: [String]
//    var foodId: String?
//    
//    
////    let dishType : [String]
//  
//    // Ajoutez d'autres propriétés de recette que vous souhaitez afficher
//}
//
//struct EdamamResponse: Decodable {
//    var hits: [Hit]
//    
//
//    private enum CodingKeys: String, CodingKey {
//        case hits = "hits"
//    }
//}
//
//
//
//struct Hit: Decodable {
//    var recipe: Recipe
//    
//}


