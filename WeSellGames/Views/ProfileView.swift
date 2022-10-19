//
//  ProfileView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var products: Products
    @EnvironmentObject var userConfig: UserConfig
    @EnvironmentObject var orders: Orders
    @State private var password = ""
    @State private var alertPresented = false
    
    let haptic = UINotificationFeedbackGenerator()
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack {
            if !userConfig.isAnonymous {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.title2)
                    
                    Divider()
                    
                    Text(userConfig.user.email)
                        .font(.title3).bold()
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                NavigationLink {
                    OrdersView()
                        .environmentObject(products)
                        .environmentObject(orders)
                } label: {
                    HStack {
                        Text("Orders")
                            .font(.title2)
                            .foregroundColor(.primary)
                        Spacer()
                        Image(systemName: "chevron.right")
                            .foregroundColor(.primary)
                            .padding(.trailing)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                    
                VStack(spacing: 10) {
                    Button {
                        haptic.notificationOccurred(.success)
                        userConfig.signOut()
                    } label: {
                        Text("Sign out")
                            .foregroundColor(.red)
                    }
                    Button {
                        haptic.notificationOccurred(.error)
                        alertPresented.toggle()
                    } label: {
                        Text("Delete account")
                            .foregroundColor(.red)
                    }
                    .alert("Delete Account", isPresented: $alertPresented, actions: {
                        SecureField("Password", text: $password)
                        Button("Delete", role: .destructive) {
                            haptic.notificationOccurred(.success)
                            userConfig.deleteAcc(password)
                        }
                        Button("Cancel", role: .cancel) { password = "" }
                    }, message: {
                        Text("Enter password in order to delete your account")
                    })
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                    
                
            } else {
                SignInOrRegisterComponent()
                    .environmentObject(userConfig)
            }
        }
        .navigationTitle("My Profile")
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserConfig())
            .environmentObject(Products())
            .environmentObject(Orders())
    }
}
