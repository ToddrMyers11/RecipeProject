//
//  Recipe_List_App.swift
//  Recipe List App
//
//  Created by Todd Myers on 2021-08-13.
//

import SwiftUI

@main
struct Recipe_List_App: App {
    @StateObject var apiVM = ApiViewModel()
    @StateObject var userDefault = UserDefaultClass.instance
    var body: some Scene {
        WindowGroup {
            RecipeTabView()
                .environmentObject(apiVM)
                .environmentObject(userDefault)
        }
    }
}
