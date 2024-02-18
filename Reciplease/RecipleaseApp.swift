//
//  RecipleaseApp.swift
//  Reciplease
//
//  Created by Riboku🗿 on 20/01/2024.
//

import SwiftUI
import CoreData
@main
struct RecipleaseApp: App {
    @StateObject private var SearchRecipeView = searchRecipeViewModel()
    @StateObject private var SearchRecipeViewDetail = searchRecipeViewModel()
    
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            VStack{
                MainView()
                
            }
            .environmentObject(SearchRecipeView)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
         
//            ContentView()
               
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

