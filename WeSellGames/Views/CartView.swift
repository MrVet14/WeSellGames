//
//  CartView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    var body: some View {
        VStack {
            if cartManager.products.count != 0 {
                ScrollView {
                    ForEach(cartManager.products, id: \.id) { product in
                        ProductRow(product: product)
                    }
                }
                
                Divider()
                
                VStack {
                    HStack {
                        Text("Your cart total is:")
                        Spacer()
                        Text("\(cartManager.total.formatted(.currency(code: "USD")))")
                            .bold()
                    }
                    
                    CheckOutButton()
                        .environmentObject(cartManager)
                }
            } else {
                Text("Your cart is empty\nTry adding something, It's Fun")
                    .font(.title)
                    .multilineTextAlignment(.center)
            }
        }
        .padding()
        .navigationTitle("My Cart")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}
