//
//  Recipe.swift
//  Recipe List App
//
//  Created by Todd Myers on 2021-08-13.
//

import Foundation

class Recipe: Identifiable, Decodable {
    
    var id:UUID?
    var name:String
    var featured:Bool
   // var image2:String
   // var image2Text:String
    var image:String
    var description:String
    var prepTime:String
    var cookTime:String
    var totalTime:String
    var servings:Int
    var highlights:[String]
    var ingredients:[Ingredient]
    var directions:[String]
   
}

class Ingredient: Identifiable, Decodable {

    var id:UUID?
    var name:String
    var num:Int?
    var denom:Int?
    var unit:String?
   
}

class Picture: Identifiable, Decodable {

        var id:UUID?
        var name:String
        var num:Int?
        var directions:[String]
}
