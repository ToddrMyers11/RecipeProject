//
//  RecipeDetailView.swift
//  Recipe List App
//
//  Created by Todd Myers on 2021-08-13.
//

import SwiftUI

struct RecipeDetailView: View {
    
    var recipe:Recipe
    
    @State var selectedServingSize = 2
    @EnvironmentObject var userDefault: UserDefaultClass
    var body: some View {
        
        ScrollView {
            
            VStack (alignment: .leading) {
                
                // MARK: Recipe Image
                Image(recipe.image)
                    .resizable()
                    .scaledToFill()
                
                HStack {
                    //MARK: Recipe Title
                    Text(recipe.name)
                        .padding(.top, 20)
                        .padding(.leading)
                        .font(Font.custom("Avenir Heavy", size: 24))
                    
                    Spacer()
                    
                    Button {
                        if checkIfSaved(recipe: recipe){
                            userDefault.removeRecipe(recipe: recipe)
                        } else {
                            userDefault.setRecipe(recipe: recipe)
                        }
                        print("UserDefaults:\(userDefault.ownApiRecipe)")
                    } label: {
                        Image(systemName: checkIfSaved(recipe: recipe) ? "star.fill" : "star")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding(.top, 20)
                            .padding(.trailing)
                    }
                }
                // MARK: Serving Size Picker
                VStack (alignment: .leading) {
                    Text("Select your serving size:")
                        .font(Font.custom("Avenir", size: 15))
                    Picker("", selection: $selectedServingSize) {
                        Text("2").tag(2)
                        Text("4").tag(4)
                        Text("6").tag(6)
                        Text("8").tag(8)
                    }
                    .font(Font.custom("Avenir", size: 15))
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width:160)
                }.padding()
                
                
                // MARK: Ingredients
                VStack(alignment: .leading) {
                    Text("Ingredients")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .padding([.bottom, .top], 5)
                    
                    ForEach (recipe.ingredients) { item in
                        Text("• " + RecipeModel.getPortion(ingredient: item, recipeServings: recipe.servings, targetServings: selectedServingSize) + " " + item.name.lowercased())
                            .font(Font.custom("Avenir", size: 15))
                    }
                }
                .padding(.horizontal)
                
                // MARK: Divider
                Divider()
                
                // MARK: Directions
                VStack(alignment: .leading) {
                    Text("Directions")
                        .font(Font.custom("Avenir Heavy", size: 16))
                        .padding([.bottom, .top], 5)
                    
                    ForEach(0..<recipe.directions.count, id: \.self) { index in
                        
                        Text(String(index+1) + ". " + recipe.directions[index])
                            .padding(.bottom, 5)
                            .font(Font.custom("Avenir", size: 15))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
   private func checkIfSaved(recipe: Recipe) -> Bool{
        
        if userDefault.ownApiRecipe.contains(where: {$0.name == recipe.name}){
            return true
        }else {
            return false
        }
//        if UserDefaultClass.instance.ownApiRecipe.contains(where: { $0.id == recipe.id }) {
//            return true
//               // print("1 exists in the array")
//           } else {
//               return false
//               // print("1 does not exists in the array")
//           }
    }
}


struct RecipeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Create a dummy recipe and pass it into the detail view so that we can see a preview
        let model = RecipeModel()
        
        RecipeDetailView(recipe: model.recipes[0])
    }
}
