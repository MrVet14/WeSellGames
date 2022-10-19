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
    
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView {
            if !userConfig.signedIn {
                WelcomeScreenView()
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
                                .environmentObject(userConfig)
                        } label: {
                            CartButton()
                                .environmentObject(cartManager)
                        }
                    }
            }
        }
        .onAppear {
            userConfig.signedIn = userConfig.isSignedIn
            userConfig.getUserData()
            products.getData()
            cartManager.getCart()
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
