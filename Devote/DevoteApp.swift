//
//  DevoteApp.swift
//  Devote
//
//  Created by Nikolay  Yuchormanski on 3.05.24.
//

import SwiftUI

@main
struct DevoteApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
