//
//  Recipe.swift
//  Recipe List App
//
//  Created by Todd Myers on 2021-08-13.
//

import Foundation

// MARK: - Recipe
struct Recipe: Identifiable, Codable, Hashable {
    let id = UUID().uuidString
    let name: String
    let featured: Bool
    let image, recipeDescription, prepTime, cookTime: String
    let totalTime: String
    let servings: Int
    let highlights: [String]
    let ingredients: [Ingredient]
    let directions: [String]

    enum CodingKeys: String, CodingKey {
        case name, featured, image
        case recipeDescription = "description"
        case prepTime, cookTime, totalTime, servings, highlights, ingredients, directions
    }
}

// MARK: - Ingredient
struct Ingredient: Identifiable, Codable, Hashable {
    let id = UUID().uuidString
    let name: String
    let num: Int?
    let unit: String?
    let denom: Int?
}

//class Recipe: Identifiable, Codable {
//
//    let id = UUID().uuidString
//    var name:String
//    var featured:Bool
//   // var image2:String
//   // var image2Text:String
//    var image:String
//    var description:String
//    var prepTime:String
//    var cookTime:String
//    var totalTime:String
//    var servings:Int
//    var highlights:[String]
//    var ingredients:[Ingredient]
//    var directions:[String]
//
//}

//class Ingredient: Identifiable, Codable {
//
//    let id = UUID().uuidString
//    var name:String
//    var num:Int?
//    var denom:Int?
//    var unit:String?
//
//}

//class Picture: Identifiable, Codable {
//
//    let id = UUID().uuidString
//        var name:String
//        var num:Int?
//        var directions:[String]
//}

// first conform `Recipe` to `Equatable`
extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        lhs.id == rhs.id
    }
}
