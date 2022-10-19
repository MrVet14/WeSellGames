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
    @State private var newPassword = ""
    @State private var newPasswordControl = ""
    @State private var newEmail = ""
    @State private var deleteAccAlertPresented = false
    @State private var changePassAlertPresenter = false
    @State private var changeEmailAlertPresented = false
    
    let haptic = UINotificationFeedbackGenerator()
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack {
            if !userConfig.isAnonymous {
                VStack(alignment: .leading) {
                    Text("Email")
                        .font(.title2)
                    
                    Divider()
                    HStack {
                        Text(userConfig.user.email)
                            .font(.title3).bold()
                        
                        Spacer()
                        
                        Image(systemName: "pencil.circle")
                            .font(.title2)
                            .padding(3)
                            .foregroundColor(.white)
                            .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                            .cornerRadius(50)
                            .onTapGesture { changeEmailAlertPresented.toggle() }
                    }
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                
                Button {
                    changePassAlertPresenter.toggle()
                } label: {
                    Text("Change password")
                        .font(.title2)
                        .foregroundColor(.primary)
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
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
                        deleteAccAlertPresented.toggle()
                    } label: {
                        Text("Delete account")
                            .foregroundColor(.red)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
            } else {
                SignInOrRegisterComponent()
                    .environmentObject(userConfig)
            }
        }
        .navigationTitle("My Profile")
        .padding()
        .alert("Change Email", isPresented: $changeEmailAlertPresented, actions: {
            TextField("New Email", text: $newEmail)
                .keyboardType(.emailAddress)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            SecureField("Password", text: $password)
            Button("Change", role: .destructive) {
                haptic.notificationOccurred(.success)
                userConfig.changeEmail(password, newEmail)
                password = ""
                newEmail = ""
            }
            Button("Cancel", role: .cancel) { password = ""; newEmail = "" }
        }, message: {
            Text("Enter new Email and password to confirm")
        })
        .alert("Change Password", isPresented: $changePassAlertPresenter, actions: {
            SecureField("Old Password", text: $password)
            SecureField("New Password", text: $newPassword)
            SecureField("Repeat New Password", text: $newPasswordControl)
            Button("Change", role: .destructive) {
                haptic.notificationOccurred(.success)
                if newPassword == newPasswordControl {
                    userConfig.changePassword(password, newPassword)
                }
                password = ""
                newPassword = ""
                newPasswordControl = ""
            }
            Button("Cancel", role: .cancel) { password = ""; newEmail = "" }
        }, message: {
            Text("Enter old password and a new one")
        })
        .alert("Delete Account", isPresented: $deleteAccAlertPresented, actions: {
            SecureField("Password", text: $password)
            Button("Delete", role: .destructive) {
                haptic.notificationOccurred(.success)
                userConfig.deleteAcc(password)
                password = ""
            }
            Button("Cancel", role: .cancel) { password = "" }
        }, message: {
            Text("Enter password in order to delete your account")
        })
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
