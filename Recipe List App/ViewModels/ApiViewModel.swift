//
//  ApiViewModel.swift
//  Recipe List App
//
//  Created by Sazza on 26/10/22.
//

import Foundation


class ApiViewModel: ObservableObject {
    @Published var recipeResult: RecipeResultModel?
    @Published var query: String = ""
    @Published var apiCurrentIngredients: ApiRecipeIngredients?
    @Published var apiCurrentInstructions: ApiRecipeInstruction?
    @Published var filterValue = FilterValue()
    @Published var offset = 0 // The number of results to skip (between 0 and 900)
    private var apiLinks = ApiLinks.self
//    init(){
//        fetchRecipeResult()
//    }
    
    func checkFilter()->String{
        var returnStr = ""
        if filterValue.isVegeterian {
            returnStr = returnStr + "&diet=\(filterType.vegeterian.rawValue)"
        }
        if filterValue.isVegan{
            returnStr = returnStr + "&diet=\(filterType.vegan.rawValue)"
        }
        if filterValue.isGlutenFree{
            returnStr = returnStr + "&diet=\(filterType.glutenFree.rawValue)"
        }
        if filterValue.isKetogenic{
            returnStr = returnStr + "&diet=\(filterType.ketogenic.rawValue)"
        }
        if filterValue.isLactoVegetarian{
            returnStr = returnStr + "&diet=\(filterType.lactoVegetarian.rawValue)"
        }
        if filterValue.isOvoVegetarian{
            returnStr = returnStr + "&diet=\(filterType.ovoVegetarian.rawValue)"
        }
        if filterValue.isPescetarian{
            returnStr = returnStr + "&diet=\(filterType.pescetarian.rawValue)"
        }
        if filterValue.isPrimal{
            returnStr = returnStr + "&diet=\(filterType.primal.rawValue)"
        }
        if filterValue.isLowFODMAP{
            returnStr = returnStr + "&diet=\(filterType.lowFODMAP.rawValue)"
        }
        if filterValue.isWhole30{
            returnStr = returnStr + "&diet=\(filterType.whole30.rawValue)"
        }
        return returnStr
    }
    
    /// To search for a recipe and get a list
    func fetchRecipeResult() {
        guard let url = URL(string: "\(apiLinks.apiComplexSearch.rawValue)?query=\(query)\(checkFilter())&number=\(AppConstant.apiNumber)&offset=\(offset)&apiKey=\(AppConstant.apiKey)") else {
            print("URL Error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //Convert to JSON
            do {
                let recipeResult = try JSONDecoder().decode(RecipeResultModel.self, from: data)
                DispatchQueue.main.async {
                    self?.recipeResult = recipeResult
                  //  print(recipeResult)
                }
            }
            catch {
                print(error.localizedDescription)
                print(String(describing: error))
                print("error")
            }
        }
        task.resume()
    }
    
    /// To get ingredients of specific recipe by id
    func fetchIngredientsById(id:Int) {
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/ingredientWidget.json?apiKey=\(AppConstant.apiKey)") else {
            print("URL Error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //Convert to JSON
            do {
                let ingredients = try JSONDecoder().decode(ApiRecipeIngredients.self, from: data)
                DispatchQueue.main.async {
                    self?.apiCurrentIngredients = ingredients
                    print(ingredients)
                }
            }
            catch {
                print(error.localizedDescription)
                print(String(describing: error))
                print("error")
            }
        }
        task.resume()
    }
    
    /// Get an individual recipe by id
    func fetchRecipeById(id:Int) {
        ///https://api.spoonacular.com/recipes/324694/analyzedInstructions?apiKey=b9b9a540f25642d794df30f3ef768ab6
        guard let url = URL(string: "https://api.spoonacular.com/recipes/\(id)/analyzedInstructions?apiKey=\(AppConstant.apiKey)") else {
            print("URL Error")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            //Convert to JSON
            do {
                let instructions = try JSONDecoder().decode(ApiRecipeInstruction.self, from: data)
                DispatchQueue.main.async {
                    self?.apiCurrentInstructions = instructions
                    print(instructions)
                }
            }
            catch {
                print(error.localizedDescription)
                print(String(describing: error))
                print("error")
            }
        }
        task.resume()

    }
}
