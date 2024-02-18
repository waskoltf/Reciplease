//
//  ModelApi.swift
//  Reciplease
//
//  Created by Riboku🎯 on 16/02/2024.
//

import Foundation

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
    let totalTime: Double

    private enum CodingKeys: String, CodingKey {
        case label
        case image
        case ingredients
        case url
        case totalTime = "totalTime"
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
