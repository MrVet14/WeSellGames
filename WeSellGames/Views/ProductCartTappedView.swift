//
//  ProductCartTappedView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/9/22.
//

import SwiftUI

struct ProductCartTappedView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        Text(product.name)
    }
}

struct ProductCartTappedView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCartTappedView(product: productList[1])
            .environmentObject(CartManager())
    }
}
