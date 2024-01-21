//
//  RecipleaseApp.swift
//  Reciplease
//
//  Created by Riboku🗿 on 20/01/2024.
//

import SwiftUI

@main
struct RecipleaseApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
//            MainViez()
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
