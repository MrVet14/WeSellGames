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
    
    let haptic = UINotificationFeedbackGenerator()
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        VStack {
            if !userConfig.isAnonymous {
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
                        haptic.notificationOccurred(.success)
                        userConfig.signOut()
                    } label: {
                        Text("Sign out")
                            .foregroundColor(.red)
                    }
                    Button {
                        haptic.notificationOccurred(.error)
                        userConfig.deleteAcc()
                    } label: {
                        Text("Delete account")
                            .foregroundColor(.red)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                    
                
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
//                            .onTapGesture {
//                                impactLight.impactOccurred()
//                            }
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
//                            .onTapGesture {
//                                impactLight.impactOccurred()
//                            }
                    }
                }
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
