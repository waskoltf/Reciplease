//
//  MainViez.swift
//  Reciplease
//
//  Created by Riboku🗿 on 20/01/2024.
//

import SwiftUI

struct MainView: View {
    
    init() {
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
//        UITabBar.appearance().barTintColor = UIColor.black
              UITabBar.appearance().backgroundColor = UIColor(named: "SlightlyMainColor") ?? UIColor.white
              UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 30)!]
              UINavigationBar.appearance().titleTextAttributes?[.foregroundColor] = UIColor.black
      }
    @State var selection = 0
    var body: some View {
        NavigationStack{
            
       
        TabView(selection: $selection){

                      SearchView()
                          .tabItem {
                              Label("Search", systemImage: "magnifyingglass.circle")
                                  .foregroundStyle(.gray)
                                 
                          }
                          .toolbar(.visible, for: .tabBar)
                          .tag(0)
                      
                      
                      
                      
                      
                      FavoriteView()
                          .tabItem {
                              Label("Favorites", systemImage: "star")
                                  .foregroundStyle(.gray)
                          }
                          .toolbar(.visible, for: .tabBar)
                          .tag(1)
                      
            
                      
                  }
        .accentColor(Color.pink)
//        .navigationTitle(selection == 0 ? "Reciplease" : (selection == 1 ? "Favorites" : ""))
        .navigationTitle(selection == 0 ? "Reciplease" : "")
                   .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarColorScheme(.dark, for: .tabBar)
              }
        }
    }


#Preview {
    MainView()
}
