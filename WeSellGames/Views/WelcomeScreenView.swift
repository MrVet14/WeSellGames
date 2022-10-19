//
//  WelcomeScreenView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import SwiftUI

struct WelcomeScreenView: View {
    @EnvironmentObject var userConfig: UserConfig
    
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 0.919, green: 0.177, blue: 0.991), Color(red: 0.377, green: 0.816, blue: 0.879)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                VStack {
                    Image("Icon")
                        .resizable()
                        .frame(width: 300, height: 300)
                        .scaledToFit()
                        .padding(.bottom, 60)
                    
                    VStack(alignment: .center) {
                        Text("Welcome to WeSellGames")
                            .font(.title)
                            .padding(.bottom, 2)
                        Text("We provide an enormous variety of games\nwith an amazing prices")
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 1)
                        Text("Wanna check it out?")
                            .padding(.bottom, 20)
                        
                        HStack {
                            NavigationLink {
                                SignInOrRegisterView(isSignInViewPresented: false)
                                    .environmentObject(userConfig)
                            } label: {
                                Text("Register")
                                    .font(.title3)
                                    .padding()
                                    .foregroundColor(.white)
                                    .frame(width: 150)
                                    .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                                    .cornerRadius(10)
//                                    .onTapGesture {
//                                        impactLight.impactOccurred()
//                                    }
                            }
                            
                            Text("OR")
                                .padding(5)
                            
                            NavigationLink {
                                SignInOrRegisterView(isSignInViewPresented: true)
                                    .environmentObject(userConfig)
                            } label: {
                                Text("Sign in")
                                    .font(.title3)
                                    .padding()
                                    .foregroundColor(.white)
                                    .frame(width: 150)
                                    .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                                    .cornerRadius(10)
//                                    .onTapGesture {
//                                        impactLight.impactOccurred()
//                                    }
                            }
                        }
                        
                        Button {
                            impactLight.impactOccurred()
                            userConfig.anonymousAcc()
                        } label: {
                            Text("Continue as a guest")
                                .foregroundColor(.secondary)
                                .padding(.vertical, 5)
                        }
                        
    //                    Text("Also you can")
    //                        .foregroundColor(.secondary)
    //                        .padding(.vertical, 5)

    //                    SignInWithGoogleButton()
    //                        .environmentObject(userConfig)
                    }
                }
                .padding()
            }
        }
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
            .environmentObject(UserConfig())
    }
}
