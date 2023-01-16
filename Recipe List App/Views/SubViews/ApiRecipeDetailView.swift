//
//  ApiRecipeDetailView.swift
//  Recipe List App
//
//  Created by Sazza on 7/11/22.
//

import SwiftUI

struct ApiRecipeDetailView: View {
    @EnvironmentObject var apiVM: ApiViewModel
    @EnvironmentObject var userDefault: UserDefaultClass
    @State var result: Result
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(alignment: .leading){
                HeaderImage
                HederTitelView
                IngredientsView
                Divider()
                if apiVM.apiCurrentInstructions != nil {
                    DirectionView
                }
            }
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .task {
            apiVM.fetchIngredientsById(id: result.id)
            apiVM.fetchRecipeById(id: result.id)
        }
    }
    
    private var HeaderImage: some View{
        VStack{
            AsyncImage(
                url: URL(string: result.image),
                content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight*0.25)
                        .clipped()
                },
                placeholder: {
                    ProgressView()
                        .frame(maxWidth: UIScreen.screenWidth, maxHeight: UIScreen.screenHeight*0.25)
                }
            )
            .overlay(alignment: .topTrailing) {
                Button {
                    if checkIfApiSaved(recipe: result){
                        userDefault.removeApiRecipe(recipe: result)
                    } else {
                        userDefault.setApiRecipe(recipe: result)
                    }
                    print("UserDefaults:\(userDefault.recipeApiRecipe)")
                } label: {
                    Image(systemName: checkIfApiSaved(recipe: result) ? "heart.fill" : "heart")
                        .font(.title)
                        .foregroundColor(.red)
                        .padding(.top, 20)
                        .padding(.trailing)
                }

            }
        }
    }
    private func checkIfApiSaved(recipe: Result) -> Bool{
        
        if userDefault.recipeApiRecipe.contains(where: {$0.id == recipe.id}){
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
    private var HederTitelView: some View {
        VStack {
            Text(result.title)
                .font(Font.custom("Avenir", size: 25))
                .bold()
                .padding(.top, 10)
        }
    }
    private var IngredientsView: some View{
        VStack(alignment: .leading){
            Text("Ingredients")
                .font(Font.custom("Avenir Heavy", size: 16))
                .padding([.bottom, .top], 5)
            ForEach(apiVM.apiCurrentIngredients?.ingredients ?? [], id:\.id) { item in
                HStack{
                    Image(systemName: "circle.fill")
                        .font(.caption2)
                    Text(item.name ?? "")
                }
            }
        }
    }
    private var DirectionView: some View {
        VStack(alignment: .leading) {
            Text("Directions")
                .font(Font.custom("Avenir Heavy", size: 16))
                .padding([.bottom, .top], 5)
            if apiVM.apiCurrentInstructions != nil && !(apiVM.apiCurrentInstructions?.isEmpty ?? false){
                if !(apiVM.apiCurrentInstructions?[0].steps?.isEmpty ?? false){
                    ForEach(0..<((apiVM.apiCurrentInstructions?[0].steps?.count ?? 0)) , id: \.self) { index in
                        HStack(alignment: .top){
                            Text("\(index + 1):")
                            Text(apiVM.apiCurrentInstructions?[0].steps?[index].step ?? "")
                        }
                    }
                }
            }
        }
    }
}

//struct ApiRecipeDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        ApiRecipeDetailView()
//    }
//}
