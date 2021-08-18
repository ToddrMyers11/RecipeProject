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
}
