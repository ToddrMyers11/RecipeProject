//
//  UserDefaultClass.swift
//  Recipe List App
//
//  Created by Sazza on 12/12/22.
//

import Foundation

class UserDefaultClass: ObservableObject{
    static let instance = UserDefaultClass()
    private init() {getSavedRecipe();getSavedApiRecipe()}
    let defaults = UserDefaults.standard
    
    @Published var ownApiRecipe: [Recipe]  = []
    @Published var recipeApiRecipe: [Result] = []
    
    func getSavedRecipe(){
        if let savedRecipe = defaults.object(forKey: UserDefaultKey.ownApiRecipe) as? Data {
            let decoder = JSONDecoder()
            if let loadedRecipe = try? decoder.decode([Recipe].self, from: savedRecipe) {
                ownApiRecipe = loadedRecipe
//                    print(loadedPerson.name)
            }
        }
    }
    
    func getSavedApiRecipe(){
        if let savedApiRecipe = defaults.object(forKey: UserDefaultKey.recipeApiRecipe) as? Data {
            let decoder = JSONDecoder()
            if let loadedRecipe = try? decoder.decode([Result].self, from: savedApiRecipe) {
                recipeApiRecipe = loadedRecipe
//                    print(loadedPerson.name)
            }
        }
    }
    
    func saveRecipe(recipe: [Recipe]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipe) {
            defaults.set(encoded, forKey: UserDefaultKey.ownApiRecipe)
        }
    }
    
    func saveApiRecipe(recipe: [Result]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(recipe) {
            defaults.set(encoded, forKey: UserDefaultKey.recipeApiRecipe)
        }
    }
    
    func setRecipe(recipe: Recipe){
        self.ownApiRecipe.append(recipe)
        self.saveRecipe(recipe: self.ownApiRecipe)
        self.getSavedRecipe()
    }
    
    func setApiRecipe(recipe: Result){
        self.recipeApiRecipe.append(recipe)
        self.saveApiRecipe(recipe: self.recipeApiRecipe)
        self.getSavedApiRecipe()
    }
    
    func removeRecipe(recipe:Recipe){
        if let index = ownApiRecipe.firstIndex(where: {$0.name == recipe.name}){
            ownApiRecipe.remove(at: index)
        }
        self.saveRecipe(recipe: self.ownApiRecipe)
        self.getSavedRecipe()
    }
    
    func removeApiRecipe(recipe:Result){
        if let index = recipeApiRecipe.firstIndex(where: {$0.id == recipe.id}){
            recipeApiRecipe.remove(at: index)
        }
        self.saveApiRecipe(recipe: self.recipeApiRecipe)
        self.getSavedApiRecipe()
    }
    
//    {
//        get {
//            
//            if let savedRecipe = defaults.object(forKey: UserDefaultKey.ownApiRecipe) as? Data {
//                let decoder = JSONDecoder()
//                if let loadedRecipe = try? decoder.decode([Recipe].self, from: savedRecipe) {
//                    return loadedRecipe
////                    print(loadedPerson.name)
//                }
//            }
//            return []
//            
////            return defaults.object(forKey: UserDefaultKey.ownApiRecipe) as? [Recipe] ?? [Recipe]()
//        } set {
//            let encoder = JSONEncoder()
//            if let encoded = try? encoder.encode(newValue) {
//                defaults.set(encoded, forKey: UserDefaultKey.ownApiRecipe)
//            }
////            defaults.set(newValue, forKey: UserDefaultKey.ownApiRecipe)
//        }
//    }
}

enum UserDefaultKey{
    static let ownApiRecipe = "ownApiRecipe"
    static let recipeApiRecipe = "recipeApiRecipe"
}
