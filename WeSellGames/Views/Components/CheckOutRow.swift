//
//  CheckOutRow.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CheckOutRow: View {
    @EnvironmentObject var products: Products
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    var body: some View {
        HStack(spacing: 20) {
            WebImage(url: products.retrievedProductImages["\(product.image)"])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(product.name)
                    .bold()
                
                Text("\(product.price.formatted(.currency(code: "USD")))")
            }
            
            Spacer()
            
            Text("x\(product.quantity)")
                .padding(.trailing, 30)
            
            Text(getTotalPerItem(product))
                .bold()

        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func getTotalPerItem(_ product: Product) -> String {
        var total: Double {
            return product.price * Double(product.quantity)
        }
        return "\(total.formatted(.currency(code: "USD")))"
    }
}

struct CheckOutRow_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutRow(product: Product(name: "Surviving Mars", image: "survivingMars", landImages: ["survivingMars-land1", "survivingMars-land2", "survivingMars-land3"], description: "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process.", price: 20.0, quantity: 1))
            .environmentObject(CartManager())
            .environmentObject(Products())
    }
}
