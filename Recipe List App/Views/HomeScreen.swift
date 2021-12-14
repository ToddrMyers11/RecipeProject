//

import SwiftUI
struct HomeScreen: View {
   
    
    @EnvironmentObject var model:RecipeModel
    var body: some View {
        
        VStack (alignment: .leading) {
           
        Text("Mamaw's Recipes")
            .bold()
            .padding(.leading)
            .padding(.top, 40)
            .font(.largeTitle)
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
            .environmentObject(RecipeModel())
    }
}

