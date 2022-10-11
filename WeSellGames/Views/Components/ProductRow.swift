//
//  ProductRow.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/9/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductRow: View {
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
            
            Image(systemName: "trash")
                .foregroundColor(.red)
                .onTapGesture {
                    cartManager.removeFormCart(product: product)
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: Product(name: "Surviving Mars", image: "survivingMars", landImages: ["survivingMars-land1", "survivingMars-land2", "survivingMars-land3"], description: "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process.", price: 20.0))
            .environmentObject(CartManager())
    }
}
