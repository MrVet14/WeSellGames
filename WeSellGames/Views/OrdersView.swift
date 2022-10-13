//
//  OrdersView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct OrdersView: View {
    @EnvironmentObject var orders: Orders
    @EnvironmentObject var products: Products
    
    var body: some View {
        VStack {
            if orders.orders.isEmpty {
                Text("You don't have any orders yet")
                    .font(.title2)
                    .multilineTextAlignment(.center)
            } else {
                VStack {
                    ForEach(orders.orders, id: \.id) { order in
                        NavigationLink {
                            OrderDetailView(order: order)
                                .environmentObject(orders)
                                .environmentObject(products)
                        } label: {
                            OrderRow(order: order)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .padding()
        .navigationTitle("Orders")
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
            .environmentObject(Orders())
            .environmentObject(Products())
    }
}
