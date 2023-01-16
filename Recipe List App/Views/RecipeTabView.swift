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
                    }
                }
            RecipeFeaturedView()
                .tabItem {
                    VStack{
                        Image(systemName: "heart.fill")
                        Text("Mamaw's Recipes")
                        
                    }
                }
            RecipeListView()
                .tabItem {
                    VStack{
                        Image(systemName: "list.bullet")
                        Text("Family Recipes")
                        
                    }
                }
            ApiRecipeListView()
                .tabItem {
                    VStack{
                        Image(systemName: "book.fill")
                        Text("Recipe Book")
                    }
                }
//            Text("Favorites")
//                .tabItem {
//                    VStack{
//                        Image(systemName: "star.fill")
//                        Text("Favorites")
//                    }
//                }
                
        }
        .environmentObject(RecipeModel())
        
        // Ommits the Tab Bar Transparency
        .onAppear {
                        // correct the transparency bug for Tab bars
                        let tabBarAppearance = UITabBarAppearance()
                        tabBarAppearance.configureWithOpaqueBackground()
                        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
                        // correct the transparency bug for Navigation bars
                        let navigationBarAppearance = UINavigationBarAppearance()
                        navigationBarAppearance.configureWithOpaqueBackground()
                        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
                    }
    }
}

struct RecipeTabView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeTabView()
    }
}
