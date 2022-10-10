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
    
    var body: some View {
        NavigationView {
            MainShopView()
                .navigationTitle("WeSellGames")
                .toolbar {
                    NavigationLink {
                        ProfileView()
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
        .onAppear { products.getData() }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(CartManager())
    }
}
