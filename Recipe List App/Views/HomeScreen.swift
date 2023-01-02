//

import SwiftUI
struct HomeScreen: View {
    
    //let imageArray: [[String]] = [["MM1", "memo1"], ["MM2", "memo2"], ["MM3", "memo3"]]
    let imageArray = ["Easter at Chestnut Acres 2010", "John & Phyllis Wedding Reception 1966", "June & Bobby in Madison 1960", "June & Brothers", "June & Georgie in Ravenswood", "June in Old Kitchen 820 Virgina St.", "Junie & Duane in Madison","Junie and Harold in Madison","Junie outside home on Cemetery Hill Oct 1956","Junie, Sandy and Roger with 1956 Plymouth","Todd & Mamaw, Bahamas"]
    
    @EnvironmentObject var model:RecipeModel
    //@State var isDetailViewShowing = false
    @State var tabSelectionIndex = 0
    var body: some View {
        
        VStack (alignment: .leading) {
            
            Text("Mamaw's Recipes")
                .bold()
                .padding(.leading)
                .padding(.bottom, -5)
                .font(.largeTitle)
            ScrollView{
                Text("June Harless (3/21/1935 - 8/16/2013) was one of the greatest cooks to come out of Boone County, WV. From a young age she raised her brothers and then her own family without many resources. She loved her children, grandchildren and great-grandchildren with great passion and food was her language of love. Her favorite part of cooking was seeing those she loved enjoying her food. This is a collection of recipes that she perfected over her 60 years of cooking. She used simple ingredients to make mouth-watering meals that we will always remember. The smell of her recipes still fill our homes today. ")
                //.bold()
                    .padding(.leading)
                    .padding(.bottom, 5)
                    .font(.system(size: 12.0))
            }.frame(width: 368, height: 150, alignment: .center)
            
            GeometryReader { geo in
                TabView (selection: $tabSelectionIndex) {
                    //Loop through each recipe
                    ForEach(0..<imageArray.count, id: \.self) { index in
                        
                        //       VStack {
                        //          List(list, id: \.self) { item in
                        //                Text("item = \(item)")
                        //              }
                        
                        
                        
                        //recipe card button
                        Button(action: {
                            // Show the recipe detail sheet
                            // self.isDetailViewShowing = true
                        }, label: {
                            // Recipe card
                            ZStack{
                                Rectangle()
                                    .foregroundColor(.white)
                                
                                VStack(spacing: 0){
                                    Image(imageArray[index])
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .clipped()
                                    Text(imageArray[index])
                                    //.padding(5)
                                        .font(Font.custom("Avenir", size: 15))
                                }
                            }
                        })
                        .tag(index)
                        
                        .buttonStyle(PlainButtonStyle())
                        .frame(width: geo.size.width - 40, height: geo.size.height - 10
                               , alignment: .center)
                        .cornerRadius(15)
                        .shadow(color: Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: -5, y: 5)
                        
                    } 
                }
                .tabViewStyle(PageTabViewStyle.init(indexDisplayMode: .never))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .interactive))
            }
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
   static var previews: some View {
      
     
       HomeScreen()
        //  .environmentObject()
   }
}


