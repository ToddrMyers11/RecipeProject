//
//  ContentView.swift
//  Family Recipes App
//
//  Created by Todd Myers 2021-08-13.
//

import SwiftUI

struct RecipeListView: View {
    
    // Reference the view model
    @EnvironmentObject var model:RecipeModel
    @EnvironmentObject var apiVM: ApiViewModel
    @State var query = ""
    var body: some View { 
        NavigationView {
            VStack (alignment: .leading, spacing: 10) {
                Text("Family Recipes")
                    .bold()
                //.padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 24))
                ScrollView {
                    LazyVStack (alignment: .leading) {
                        ForEach(model.recipes) { recipe in
                            
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
            .navigationBarHidden(true)
            .padding(.leading)
        }
    }
}
struct RecipeRowItem:View{
    @State var recipe: Recipe
    var body: some View{
        HStack(spacing: 20.0) {
            Image(recipe.image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50, alignment: .center)
                .clipped()
                .cornerRadius(5)
            VStack(alignment: .leading) {
                Text(recipe.name)
                    .foregroundColor(.black)
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights: recipe.highlights)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
            }
        }
    }
}
struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
            .environmentObject(RecipeModel())
    }
}
