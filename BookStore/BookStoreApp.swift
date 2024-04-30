//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Enrique Sarmiento on 29/4/24.
//

import SwiftUI

@main
struct BookStoreApp: App {
   @StateObject private var store = Store()
    var body: some Scene {
        WindowGroup {
           ContentView().environmentObject(store)
        }
    }
}
