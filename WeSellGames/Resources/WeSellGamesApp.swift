//
//  WeSellGamesApp.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      FirebaseApp.configure()
    return true
  }
}

@main
struct WeSellGamesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var cartManager = CartManager()
    @StateObject var products = Products()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cartManager)
                .environmentObject(products)
        }
    }
}
