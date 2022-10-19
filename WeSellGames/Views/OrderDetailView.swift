//
//  OrderDetailView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct OrderDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var products: Products
    @EnvironmentObject var orders: Orders
    @State private var showAlert = false
    var order: Order
    
    let haptic = UINotificationFeedbackGenerator()
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Order was delivered to this email")
                        .font(.title2)
                    
                    Divider()
                    
                    Text(order.email)
                        .font(.title3).bold()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                
                ForEach(order.orderedProducts, id: \.id) { item in
                    DetailOrdersRow(order: item)
                }
            }
            
            VStack {
                Button {
                    showAlert.toggle()
                } label: {
                    Text("Cancel order")
                        .font(.title3)
                        .foregroundColor(.red)
                }
                .padding()
                .padding(.horizontal, 20)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                .alert("You sure you wanna cancel your order?", isPresented: $showAlert) {
                    Button("Yes", role: .destructive) {
                        haptic.notificationOccurred(.success)
                        orders.deleteData(order: order)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    Button("No", role: .cancel) { }
                }
            }
        }
        .padding()
        .navigationTitle("Order #. \(order.id)")
    }
}

struct OrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        OrderDetailView(order: Order(id: "awfwafawfwffegege", email: "Test", orderedProducts: [], total: 30.00))
            .environmentObject(Orders())
            .environmentObject(Products())
    }
}
