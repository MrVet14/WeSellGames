//
//  MainShopView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct MainShopView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var products: Products
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(products.productList, id: \.id) { product in
                    ProductCard(product: product)
                        .environmentObject(cartManager)
                        .environmentObject(products)
                }
            }
            .padding()
        }
    }
}

struct MainShopView_Previews: PreviewProvider {
    static var previews: some View {
        MainShopView()
            .environmentObject(CartManager())
            .environmentObject(Products())
    }
}
