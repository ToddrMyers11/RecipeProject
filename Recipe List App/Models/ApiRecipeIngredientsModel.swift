//
//  ApiRecipeIngredientsModel.swift
//  Recipe List App
//
//  Created by Sazza on 7/11/22.
//

import Foundation

// MARK: - Welcome
struct ApiRecipeIngredients: Codable {
    let ingredients: [ApiIngredient]?
}

// MARK: - Ingredient
struct ApiIngredient: Codable, Identifiable {
    let id = UUID()
    let amount: Amount?
    let image, name: String?
}

// MARK: - Amount
struct Amount: Codable {
    let metric, us: Metric?
}

// MARK: - Metric
struct Metric: Codable {
    let unit: String?
    let value: Double?
}
