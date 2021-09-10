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
    var body: some View {
        
        VStack (alignment: .leading) {
           
        Text("Featured Recipes")
            .bold()
            .padding(.leading)
            .padding(.top, 40)
            .font(.largeTitle)
            
            
        GeometryReader { geo in
        TabView{
            //Loop through each recipe
            ForEach (0..<model.recipes.count)
            {index in
            //Only show those that should be featured
            if model.recipes[index].featured == true {
            
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
                            Image(model.recipes[index].image)
                                .resizable()
                                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                                .clipped()
                            Text(model.recipes[index].name)
                                .padding(5)
                            
                                  
                                    }
                        
                    }
                    
                })
                .sheet(isPresented: $isDetailViewShowing) {
                   // Show the recipe detail view
                    RecipeDetailView(recipe: model.recipes[index])
                }
                .buttonStyle(PlainButtonStyle())
                .frame(width: geo.size.width - 40, height: geo.size.height - 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .cornerRadius(15)
                .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -5, y: 5)
                
                
                //recipe card
            
           
        }
        }
   
        }
        .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .automatic))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
        
            VStack (alignment: .leading, spacing: 10) {
            Text("Preparation Time:")
                .font(.headline)
            Text("1 hour")
            Text("Highlights")
                .font(.headline)
            Text("Healthy, Hearty")
        }
            .padding([.leading, .bottom])
        }
        }
}
struct RecipeFeaturedView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeFeaturedView()
            .environmentObject(RecipeModel())
    }
}

