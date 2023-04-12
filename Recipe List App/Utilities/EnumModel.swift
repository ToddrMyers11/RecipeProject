//
//  EnumModel.swift
//  Recipe List App
//
//  Created by Sazza on 28/10/22.
//

import Foundation

enum ApiLinks:String{
    case apiComplexSearch = "https://api.spoonacular.com/recipes/complexSearch"
    case apiSearchById = "https://api.spoonacular.com/recipes/{id}/ingredientWidget.json"
    case none = ""
}

enum RecipeTab:String{
    case favourites = "Favorites"
    case search = "Search"
}

enum FavouriteTab: String {
    case mamawS = "Mamaw's Recipes"
    case recipeBook = "Recipe Book"
}
