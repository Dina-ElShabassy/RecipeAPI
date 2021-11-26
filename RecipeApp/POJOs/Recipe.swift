//
//  Recipe.swift
//  RecipeApp
//
//  Created by Dina ElShabassy on 11/25/21.
//  Copyright © 2021 Dina_ElShabassy. All rights reserved.
//

import Foundation

struct Data: Codable {
    var hits: [Recipe]?
}

struct Recipe: Codable {
    var recipe: RecipeDetails?
}

struct RecipeDetails: Codable {
    var label, image, source, url: String?
    var healthLabels, ingredientLines: [String]?
}
