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
    @EnvironmentObject var orders: Orders
    
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
                                .environmentObject(orders)
                                .environmentObject(products)
                        } label: {
                            ProfileButton()
                        }
                        NavigationLink {
                            CartView()
                                .environmentObject(cartManager)
                                .environmentObject(orders)
                        } label: {
                            CartButton(numberOfProduct: cartManager.products.count)
                        }
                    }
            }
        }
        .onAppear {
            userConfig.signedIn = userConfig.isSignedIn
            userConfig.getUserData()
            products.getData()
            orders.getData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
            .environmentObject(Products())
            .environmentObject(UserConfig())
            .environmentObject(Orders())
    }
}
