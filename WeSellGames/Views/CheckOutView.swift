//
//  CheckOutView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct CheckOutView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var email: String = ""
    @Binding var checkOutViewOpen: Bool
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Items to Check Out:")
                    .font(.title2)
                Divider()
                ScrollView {
                    ForEach(cartManager.products, id: \.id) { product in
                        CheckOutRow(product: product)
                    }
                }
            }
            
            Divider()
            
            VStack(alignment:.leading) {
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                
                Text("Your order will be immediately delivered to your email address.")
                    .font(.caption)
                    .padding(.bottom, 1)
                
                HStack {
                    Text("Total :")
                        .font(.title2)
                    Spacer()
                    Text("\(cartManager.total.formatted(.currency(code: "USD")))")
                        .font(.title2).bold()
                }
                
                Button {
                    cartManager.products.removeAll()
                    checkOutViewOpen.toggle()
                } label: {
                        Text("Confirm")
                            .font(.title)
                            .fontWeight(.medium)
                    }
                    .foregroundColor(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
            }
        }
        .padding()
    }
}

//struct CheckOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckOutView(checkOutViewOpen: true)
//            .environmentObject(CartManager())
//    }
//}
