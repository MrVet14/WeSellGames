//
//  DetailOrdersRow.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailOrdersRow: View {
    @EnvironmentObject var products: Products
    var order: Order.Products
    
    var body: some View {
        HStack(spacing: 20) {
            WebImage(url: products.retrievedProductImages["\(order.image)"])
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(order.name)
                    .font(.title3).bold()
                    .lineLimit(2)
                
                Text("\(order.price.formatted(.currency(code: "USD")))")
            }
            
            Spacer()
            
            Text("x\(order.quantity)")
                .padding(.trailing, 30)
            
            Text(getTotalPerItem(order))
                .bold()

        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
    
    func getTotalPerItem(_ product: Order.Products) -> String {
        var total: Double {
            return product.price * Double(product.quantity)
        }
        return "\(total.formatted(.currency(code: "USD")))"
    }
}

struct DetailOrdersRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailOrdersRow(order: Order.Products(id: UUID(), name: "Dome Keeper", price: 17, quantity: 1, image: "domeKeeper"))
            .environmentObject(Products())
    }
}
