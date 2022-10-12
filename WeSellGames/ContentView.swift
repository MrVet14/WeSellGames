//
//  ContentView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var products: Products
    @EnvironmentObject var userConfig: UserConfig
    
   // @State private var isWelcomeScreenPresented = true
    
    var body: some View {
        NavigationView {
            if !userConfig.signedIn {
                WelcomeScreen()
                    .environmentObject(userConfig)
            } else {
                MainShopView()
                    .navigationTitle("WeSellGames")
                    .toolbar {
                        NavigationLink {
                            ProfileView()
                                .environmentObject(userConfig)
                        } label: {
                            ProfileButton()
                        }
                        NavigationLink {
                            CartView()
                                .environmentObject(cartManager)
                        } label: {
                            CartButton(numberOfProduct: cartManager.products.count)
                        }
                    }
            }
        }
        .onAppear {
            products.getData()
            userConfig.signedIn = userConfig.isSignedIn
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
    }
}
