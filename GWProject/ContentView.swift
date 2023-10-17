//
//  ContentView.swift
//  GWProject
//
//  Created by Sai Harshith Tanguturi on 8/21/23.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
