//
//  ProfileView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userConfig: UserConfig
    @State private var showingDeleteAlert = false
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
            
            VStack(spacing: 10) {
                Button {
                    userConfig.signOut()
                } label: {
                    Text("Sign out")
                        .foregroundColor(.red)
                }
                Button {
                    //showingDeleteAlert.toggle()
                    userConfig.deleteAcc()
                    
                } label: {
                    Text("Delete account")
                        .foregroundColor(.red)
                } //Alert works only on IOS16
//                .alert("Delete Account", isPresented: $showingDeleteAlert, actions: {
//                    SecureField("Password", text: $password)
//
//                    Button("Delete Account", role: .destructive, action: {  userConfig.deleteAcc(password) })
//                    Button("Cancel", role: .cancel, action: {})
//                }, message: {
//                    Text("Please, enter your password to confirm action")
//                })
                

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
    }
}


