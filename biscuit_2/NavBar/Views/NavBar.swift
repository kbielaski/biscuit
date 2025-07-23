//
//  NavBar.swift
//  biscuit_2
//
//  Created by kelly on 7/23/25.
//

import SwiftUI

enum TabIdentifier: String {
    case recipeFeed
    case groceryList
    case create
    case personalRecipes
    case account
}

struct NavBarView: View {
    @State var selectedTab: TabIdentifier = TabIdentifier.recipeFeed
    @State var showCreateMenu: Bool = false
 
    var body: some View {
        TabView(selection: $selectedTab) {
            RecipeFeedView()
                .tabItem {
                    Label("Recipe Feed", systemImage: "person.3")
                }.tag(TabIdentifier.recipeFeed)
            
            GroceryListView()
                .tabItem {
                    Label("Grocery List", systemImage: "carrot")
                }.tag(TabIdentifier.groceryList)
            
            // TODO: This shouldn't cover the tab bar
            // consider custom tab bar https://www.youtube.com/watch?v=8Ys83qvnDvE
            Text("hello world").tabItem {
                    Label("Create", systemImage: "plus")
            }.tag(TabIdentifier.create)
            
            PersonalRecipesView()
                .tabItem {
                    Label("Your Recipes", systemImage: "fork.knife")
                }.tag(TabIdentifier.personalRecipes)
            
            MyAccountView()
                .tabItem {
                    Label("My Account", systemImage: "person.crop.circle")
                }.tag(TabIdentifier.account)
        }.onChange(of: selectedTab) { newValue in
            if newValue == .create {
                showCreateMenu = true // Trigger the menu presentation
            }
        }
        .sheet(isPresented: $showCreateMenu) {
            Text("hello").presentationDetents([.medium])
            //SettingsMenuView() // Your menu or options view
        }
    }

}

struct NavBarView_Previews:
    PreviewProvider
{
    static var previews: some View {
        NavBarView()
    }
}
