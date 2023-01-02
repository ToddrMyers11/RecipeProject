//
//  ApiRecipeListView.swift
//  Recipe List App
//
//  Created by Sazza on 7/11/22.
//

import SwiftUI

struct ApiRecipeListView: View {
    @EnvironmentObject var apiVM: ApiViewModel
    @EnvironmentObject var userDefault: UserDefaultClass
    @State var selectedTab:RecipeTab = .search
    @State var selectedFavoriteTab: FavouriteTab = .mamawS
    @State var isFiltering = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading,spacing: 0){
                Header
                TopTabBar
                    .frame(maxWidth: .infinity, alignment: .center)
                if selectedTab == .search{
                    SearchView
                } else {
                    FavouriteView
                }
            }
            .navigationBarHidden(true)
            .padding(.leading)
            .opacity(isFiltering ? 0.3 : 1.0 )
            .disabled(isFiltering)
            if isFiltering{
                FilterView
            }
        }
        .embedInNavigationView()
    }
    /// Header
    private var Header: some View{
        VStack(alignment: .center){
            if selectedTab == .search{
                Text("Search")
                    .bold()
                //.padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 24))
            } else {
                Text("Your Favorites")
                    .bold()
                //.padding(.top, 40)
                    .font(Font.custom("Avenir Heavy", size: 24))
            }
        }
    }
    /// Top Tab Bar
    private var TopTabBar: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 10)
            HStack(spacing: 0){
                PickerTopTab(tab: .search, selectedTab: $selectedTab)
                PickerTopTab(tab: .favourites, selectedTab: $selectedTab)
            }
        } .frame(minWidth: 260, maxWidth: 300, maxHeight: 36)
            .foregroundColor(.red)
            .padding()
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
    
    /// Search bar and search result view
    private var SearchView: some View{
        VStack{
            HStack{
                TextField("Search Recipe", text: $apiVM.query)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                Button(action: {
                    apiVM.offset = 0
                    apiVM.fetchRecipeResult()
                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title)
                        .foregroundColor(.black)
                })
                
                Button(action: {
                   // apiVM.fetchRecipeResult()
                    isFiltering = true
                }, label: {
                    Image(systemName: "slider.horizontal.3")
                        .font(.title)
                        .foregroundColor(.black)
                })
            }
            .padding()
            
            if apiVM.recipeResult != nil {
                HStack(spacing: 10) {
                    Text("Total Result: \(apiVM.recipeResult?.totalResults ?? 0)")
                        .font(Font.custom("Avenir Heavy", size: 15))
                    /// if number + offset > totalResult ? totalResult : (number + offset)
                    /// this is done to show end number when we reach end of the pages by clicking next page.
                    Text("(Currently Showing: \(apiVM.recipeResult?.offset ?? 0) - \((apiVM.recipeResult?.number ?? 0) + (apiVM.recipeResult?.offset ?? 0) > (apiVM.recipeResult?.totalResults ?? 0) ? (apiVM.recipeResult?.totalResults ?? 0) : (apiVM.recipeResult?.number ?? 0) + (apiVM.recipeResult?.offset ?? 0)))")
                        .font(Font.custom("Avenir Heavy", size: 15))
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(5)
            }
            
            ScrollView {
                LazyVStack(alignment: .leading){
                    ForEach(apiVM.recipeResult?.results ?? [], id: \.id) { result in
                        NavigationLink(destination: ApiRecipeDetailView(result: result)) {
                            HStack{
                                AsyncImage(url:URL(string: result.image))
                                    .frame(width: 50, height: 50)
                                    .clipped()
                                    .cornerRadius(5)
                                
                                Text(result.title)
                                    .foregroundColor(.black)
                                    .font(Font.custom("Avenir Heavy", size: 16))
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    NextAndPrevButton
                }
                
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
        }
    }
    /// Next and previous button
    private var NextAndPrevButton: some View{
        HStack{
            if (apiVM.recipeResult?.offset ?? 0) >= AppConstant.apiNumber {
                Button {
                    apiVM.offset -= AppConstant.apiNumber
                    apiVM.fetchRecipeResult()
                } label: {
                    HStack{
                        Image(systemName: "chevron.left")
                            .font(.title)
                        Text("Previous Page")
                            .font(.body)
                    }
                }
            }
            Spacer()
            if apiVM.recipeResult != nil && (apiVM.recipeResult?.totalResults ?? 0) > AppConstant.apiNumber && (apiVM.recipeResult?.number ?? 0) + (apiVM.recipeResult?.offset ?? 0) < (apiVM.recipeResult?.totalResults ?? 0){
                Button {
                    apiVM.offset += AppConstant.apiNumber
                    apiVM.fetchRecipeResult()
                } label: {
                    HStack{
                        Text("Next Page")
                            .font(.body)
                        Image(systemName: "chevron.right")
                            .font(.title)
                    }
                }
            }
        }
    }
    
    /// Filtering the recipe here
    private var FilterView: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .frame(width: UIScreen.screenWidth*0.8, height: UIScreen.screenHeight*0.55)
                .foregroundColor(Color(.systemGray4))
                .overlay(content: {
                    VStack(spacing: 0){
                        ZStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    isFiltering = false
                                }, label: {
                                    Image(systemName: "xmark")
                                        .font(.headline)
                                        .foregroundColor(.black)
                                })
                            }
                            Text("Filter")
                                .font(.headline)
                                .foregroundColor(.black)
                                .bold()
                        }
                        .padding()
                        Divider()
                        ScrollView{
                            VStack{
                                /// Vegiterian
                                FilterToggle(isOn: $apiVM.filterValue.isVegeterian, filterType: filterType.vegeterian)
                                /// Vegan
                                FilterToggle(isOn: $apiVM.filterValue.isVegan, filterType: filterType.vegan)
                                /// Gluten Free
                                FilterToggle(isOn: $apiVM.filterValue.isGlutenFree, filterType: filterType.glutenFree)
                                /// Ketogenic
                                FilterToggle(isOn: $apiVM.filterValue.isKetogenic, filterType: filterType.ketogenic)
                                /// LactoVegeterian
                                FilterToggle(isOn: $apiVM.filterValue.isLactoVegetarian, filterType: filterType.lactoVegetarian)
                                /// Ovo Vegiterian
                                FilterToggle(isOn: $apiVM.filterValue.isOvoVegetarian, filterType: filterType.ovoVegetarian)
                                /// Pescetarian
                                FilterToggle(isOn: $apiVM.filterValue.isPescetarian, filterType: filterType.pescetarian)
                                /// Primal
                                FilterToggle(isOn: $apiVM.filterValue.isPrimal, filterType: filterType.primal)
                                /// LowFODMAP
                                FilterToggle(isOn: $apiVM.filterValue.isLowFODMAP, filterType: filterType.lowFODMAP)
                                /// Whole30
                                FilterToggle(isOn: $apiVM.filterValue.isWhole30, filterType: filterType.whole30)
                            }
                        }
                        .padding()
                        Button(action: {
                            isFiltering = false
                        }, label: {
                            HStack{
                                Image(systemName: "magnifyingglass")
                                Text("Ok")
                            }
                        }).buttonStyle(.borderedProminent)
                            .padding()
                    }
                })
        }
    }
    
    /// User's favourite view
    private var FavouriteView: some View{
        VStack(alignment: .center, spacing: 10){
            TopFavoriteTabBar
            if selectedFavoriteTab == .mamawS {
                MamawsFavoriteRecipe
            } else {
                RecipeBookFavoriteRecipe
            }
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
                                .foregroundColor(.black)
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
}

struct FilterToggle:View{
    @Binding var isOn: Bool
    @State var filterType: filterType
    var body: some View{
        Toggle(isOn: $isOn) {
            Text("\(filterType.rawValue):")
        }
    }
}

struct PickerTopTab: View{
    @State var tab: RecipeTab
    @Binding var selectedTab: RecipeTab
    var body: some View{
        Button(action: {
            selectedTab = tab
        }, label: {
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(tab == selectedTab ? .yellow : .clear)
                Text(tab.rawValue)
                    .foregroundColor(.black)
            }
        })
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
                    .foregroundColor(.black)
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 1)
                    .foregroundColor(tab == selectedTab ? .yellow : .clear)
            }
        })
    }
}
struct ApiRecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        ApiRecipeListView()
    }
}
