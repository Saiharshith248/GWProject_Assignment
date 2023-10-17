//
//  GWProjectApp.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 8/21/23.
//

import SwiftUI
import Firebase

@main
struct GWProjectApp: App {
    
    let persistenceController = PersistenceController.shared
    init(){
        FirebaseApp.configure()
        print("FireBase Configured")
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
