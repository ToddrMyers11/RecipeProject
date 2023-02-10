//
//  FavoriteView.swift
//  Recipe List App
//
//  Created by Sazza on 10/2/23.
//

import SwiftUI

struct FavoriteView: View {
    @EnvironmentObject var userDefault: UserDefaultClass
    @State var selectedFavoriteTab: FavouriteTab = .mamawS
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 10){
                Header
                TopFavoriteTabBar
                if selectedFavoriteTab == .mamawS {
                    MamawsFavoriteRecipe
                } else {
                    RecipeBookFavoriteRecipe
                }
            }
        }.navigationBarHidden(true)
            .padding(.leading)
        
        .embedInNavigationView()
    }
    
    /// Header
    private var Header: some View{
        VStack(alignment: .center){
            Text("Your Favorites")
                .bold()
            //.padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 24))
        }
    }
    
    private var MamawsFavoriteRecipe: some View{
        ScrollView{
            LazyVStack (alignment: .leading) {
                ForEach(userDefault.ownApiRecipe, id: \.id){ recipe in
                    NavigationLink(
                        destination: RecipeDetailView(recipe:recipe),
                        label: {
                            // MARK: Row item
                            RecipeRowItem(recipe: recipe)
                        }
                    )
                }
            }
        }
    }
    
    private var RecipeBookFavoriteRecipe: some View{
        ScrollView {
            LazyVStack(alignment: .leading){
                ForEach(userDefault.recipeApiRecipe, id: \.id) { result in
                    NavigationLink(destination: ApiRecipeDetailView(result: result)) {
                        HStack{
                            AsyncImage(url:URL(string: result.image))
                                .frame(width: 50, height: 50)
                                .clipped()
                                .cornerRadius(5)
                            
                            Text(result.title)
                                .foregroundColor(.textColor)
                                .font(Font.custom("Avenir Heavy", size: 16))
                                .multilineTextAlignment(.leading)
                        }
                    }
                }
               // NextAndPrevButton
            }
            
        }
        .padding(.horizontal)
        .padding(.bottom, 10)

    }
    
    /// Top Tab Bar
    private var TopFavoriteTabBar: some View{
        ZStack{
            //RoundedRectangle(cornerRadius: 10)
            HStack(spacing: 0){
                FavoriteTopTab(tab: .mamawS, selectedTab: $selectedFavoriteTab)
                FavoriteTopTab(tab: .recipeBook, selectedTab: $selectedFavoriteTab)
            }
        }
        //.frame(minWidth: 260, maxWidth: 300, maxHeight: 36)
            //.foregroundColor(.red)
            .padding()
    }
}

struct FavoriteTopTab: View{
    @State var tab: FavouriteTab
    @Binding var selectedTab: FavouriteTab
    var body: some View{
        Button(action: {
            selectedTab = tab
        }, label: {
            VStack(alignment: .center, spacing: 4){
               
                Text(tab.rawValue)
                    .foregroundColor(.textColor)
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 1)
                    .foregroundColor(tab == selectedTab ? .yellow : .clear)
            }
        })
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
