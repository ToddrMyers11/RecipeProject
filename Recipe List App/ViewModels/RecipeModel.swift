//
//  RecipeModel.swift
//  Recipe List App
//
//  Created by Todd Myers on 2021-08-13.
//

import Foundation


class RecipeModel: ObservableObject {
    
    @Published var recipes = [Recipe]()
    
    init() {
        
        // Create an instance of data service and get the data
        self.recipes = DataService.getLocalData()
        
        
    }
    
    static func getPortion(ingredient:Ingredient, recipeServings:Int, targetServings:Int) -> String {
        
        var portion = ""
        var numerator = ingredient.num ?? 1
        var denominator = ingredient.denom ?? 1
        var wholePortions = 0
        
        if ingredient.num != nil {
            
            //Get a single serving size by multiplying denominator by the recipe servings
            denominator = denominator * recipeServings
            // or denominator *= recipeServings
            //Get target portion by multiplying numerator by target servings
            numerator = numerator * targetServings
            // or numerator *= targetServings
            //Reduce fraction by greatest common divisor
            let divisor = Rational.greatestCommonDivisor(numerator, denominator)
            numerator /= divisor
            denominator /= divisor
            //Get the whole portion if the numerator is greater than the denominator
            if numerator >= denominator {
                //Calculate the whole portion
                wholePortions = numerator/denominator
                //Calculate the remainder
                numerator = numerator % denominator
                //Assign to portion String
                portion += String(wholePortions)
            }
            //Express the remainder as a fraction
            if numerator > 0 {
                //Assign remainder as fraction to the portion string
                portion += wholePortions > 0 ? " ": "" //shorthand if statement
                portion += "\(numerator)/\(denominator)"
            }
        }
        
        if var unit = ingredient.unit {
            
            
            //if we need to pluralize
            if wholePortions > 1 {
                // Calculate the appropriate suffix
                if unit.suffix(2) == "ch" {
                    unit += "es"
                }
                else if unit.suffix(1) == "f" {
                    unit = String(unit.dropLast())
                    unit += "ves"
                }
                else {
                    unit += "s"
                }
            }
            
            portion += ingredient.num == nil && ingredient.denom == nil ? "" : " "            //inline if statement above
            return portion + unit
        }
        
        return portion
    }
}
