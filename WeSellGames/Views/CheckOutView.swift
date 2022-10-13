//
//  CheckOutView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct CheckOutView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var orders: Orders
    @EnvironmentObject var userConfig: UserConfig
    @State private var email: String = ""
    
    let haptic = UINotificationFeedbackGenerator()
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack {
            if !userConfig.isAnonymous {
                ScrollView {
                    ForEach(cartManager.products, id: \.id) { product in
                        CheckOutRow(product: product)
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
                        .keyboardType(.emailAddress)
                    
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
                        haptic.notificationOccurred(.success)
                        orders.addData(email: email, order: cartManager.products, total: cartManager.total)
                        cartManager.products.removeAll()
                        self.presentationMode.wrappedValue.dismiss()
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
            } else {
                Text("To continue you have to:")
                    .font(.title2)
                
                HStack {
                    NavigationLink {
                        Register()
                            .environmentObject(userConfig)
                    } label: {
                        Text("Register")
                            .font(.title3)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                            .cornerRadius(10)
                            .onTapGesture {
                                impactLight.impactOccurred()
                            }
                    }
                    
                    Text("OR")
                        .padding(5)
                    
                    NavigationLink {
                        SignIn()
                            .environmentObject(userConfig)
                    } label: {
                        Text("Sign in")
                            .font(.title3)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 150)
                            .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                            .cornerRadius(10)
                            .onTapGesture {
                                impactLight.impactOccurred()
                            }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Check Out")
    }
}

//struct CheckOutView_Previews: PreviewProvider {
//    static var previews: some View {
//        CheckOutView(checkOutViewOpen: true)
//            .environmentObject(CartManager())
//            .environmentObject(Orders())
//    }
//}
