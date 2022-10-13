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
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Email:")
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
                    userConfig.signOut()
                } label: {
                    Text("Sign out")
                        .foregroundColor(.red)
                }
                Button {
                    userConfig.deleteAcc()
                } label: {
                    Text("Delete account")
                        .foregroundColor(.red)
                }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
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
