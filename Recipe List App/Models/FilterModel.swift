//
//  FilterModel.swift
//  Recipe List App
//
//  Created by Sazza on 13/11/22.
//

import Foundation

struct FilterValue {
    var isVegeterian = false
    var isVegan = false
    var isGlutenFree = false
    var isKetogenic = false
    var isLactoVegetarian = false
    var isOvoVegetarian = false
    var isPescetarian = false
    var isPrimal = false
    var isLowFODMAP = false
    var isWhole30 = false
}

enum filterType: String{
    case vegeterian = "Vegetarian"
    case vegan = "Vegan"
    case glutenFree = "GlutenFree"
    case ketogenic = "Ketogenic"
    case lactoVegetarian = "Lacto-Vegetarian"
    case ovoVegetarian = "Ovo-Vegetarian"
    case pescetarian = "Pescetarian"
    case primal = "Primal"
    case lowFODMAP = "LowFODMAP"
    case whole30 = "Whole30"
}
