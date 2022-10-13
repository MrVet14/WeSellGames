//
//  OrderRow.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct OrderRow: View {
    var order: Order
    
    var body: some View {
        HStack {
            Text("Order #. \(order.id)")
                .foregroundColor(.primary)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            VStack {
                Text("Total:")
                    .foregroundColor(.secondary)
                Text("\(order.total.formatted(.currency(code: "USD")))")
                    .font(.body).bold()
                    .foregroundColor(.primary)
            }
            
            Image(systemName: "chevron.right")
                .foregroundColor(.primary)
                .padding(.horizontal)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
    }
}

struct OrderRow_Previews: PreviewProvider {
    static var previews: some View {
        OrderRow(order: Order(id: "awfwafawfwffegege", email: "Test", orderedProducts: [], total: 30.00))
    }
}
