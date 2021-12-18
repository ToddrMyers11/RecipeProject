//
//  RecipeTabView.swift
//  Recipe List App
//
//  Created by Todd Myers on 8/24/21.
//

import SwiftUI

struct RecipeTabView: View {
    var body: some View {
        TabView {
            
            HomeScreen()
                .tabItem {
                    VStack{
                        Image(systemName: "house.fill")
                        Text("Home Screen")
                    
                } }
                    RecipeFeaturedView()
                        .tabItem {
                            VStack{
                                Image(systemName: "heart.fill")
                                Text("Mamaw's Recipes")
                            
                        } }
            
           
            
                    RecipeListView()
                        .tabItem {
                            VStack{
                                Image(systemName: "list.bullet")
                                Text("All Family Recipes")
                                
                            }
                            
                        }
                }
        .environmentObject(RecipeModel())
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
