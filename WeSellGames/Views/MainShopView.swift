//
//  MainShopView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct MainShopView: View {
    @EnvironmentObject var cartManager: CartManager
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(productList, id: \.id) { product in
                    ProductCard(product: product)
                        .environmentObject(cartManager)
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
    }
}
