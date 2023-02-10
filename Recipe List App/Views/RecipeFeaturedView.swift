//
//  RecipeFeaturedView.swift
//  Recipe List App
//
//  Created by Todd Myers on 8/30/21.
//

import SwiftUI

struct RecipeFeaturedView: View {
    
    @EnvironmentObject var model:RecipeModel
    @State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    var body: some View {
        
        VStack (alignment: .leading, spacing: 0) {
            
            Text("Mamaw's Recipes")
                .bold()
                .padding(.leading)
                .padding(.top, 40)
                .font(Font.custom("Avenir Heavy", size: 24))
            
            GeometryReader { geo in
                TabView (selection: $tabSelectionIndex) {
                    //Loop through each recipe
                    
                    ForEach (0..<model.featuredRecipes.count, id: \.self)
                    {index in
                        //Only show those that should be featured
//                        if model.featuredRecipes[index].featured == true {
                            
                            //recipe card button
                            Button(action: {
                                // Show the recipe detail sheet
                                self.isDetailViewShowing = true
                            }, label: {
                                // Recipe card
                                ZStack{
                                    Rectangle()
                                        .foregroundColor(.white)
                                    
                                    VStack(spacing: 0){
                                        Image(model.featuredRecipes[index].image)
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .clipped()
                                        Text(model.featuredRecipes[index].name)
                                            .padding(5)
                                        .font(Font.custom("Avenir", size: 15))  }
                                }
                            })
                            .tag(index)
                            .buttonStyle(PlainButtonStyle())
                            .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .cornerRadius(15)
                            .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -5, y: 5)
                            //recipe card
//                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            }
            VStack (alignment: .leading, spacing: 10) {
                
                Text("Preparation Time:")
                    .font(Font.custom("Avenir Heavy", size: 16))
                //                Text(model.recipes[tabSelectionIndex].prepTime)
                Text("Highlights")
                    .font(Font.custom("Avenir Heavy", size: 16))
                RecipeHighlights(highlights: model.featuredRecipes[tabSelectionIndex].highlights)
                
            }
            .padding([.leading, .bottom])
        }
        .sheet(isPresented: $isDetailViewShowing) {
            // Show the recipe detail view
            RecipeDetailView(recipe: model.featuredRecipes[tabSelectionIndex])
        }
        .onAppear(perform: {
            setFeaturedIndex()
        })
    }
        func setFeaturedIndex() {
        // Find index of the first recipe that is featured
           var index = model.featuredRecipes.firstIndex {(recipe) -> Bool in
                return recipe.featured
        }
            tabSelectionIndex = index ?? 0
        }
}
struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}

