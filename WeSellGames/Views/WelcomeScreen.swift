//
//  WelcomeScreen.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import SwiftUI

struct WelcomeScreen: View {
    @EnvironmentObject var userConfig: UserConfig
    
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
                            }
                        }
                        
    //                    Text("Also you can")
    //                        .foregroundColor(.secondary)
    //                        .padding(.vertical, 5)
    //
    //                    Button {
    //
    //                    } label: {
    //                        HStack {
    //                            Image("Google")
    //                                .resizable()
    //                                .aspectRatio(contentMode: .fit)
    //                                .frame(width: 40, height: 40)
    //
    //                            Text("Sign In with Google")
    //                                .font(.title3)
    //                                .fontWeight(.medium)
    //                                .padding(.leading, 5)
    //                        }
    //                        .foregroundColor(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
    //                        .padding()
    //                        .frame(maxWidth: .infinity)
    //                        .background {
    //                            Capsule()
    //                                .strokeBorder(Color(hue: 0.519, saturation: 0.683, brightness: 0.703), lineWidth: 2)
    //                        }
    //                    }
                    }
                }
                .padding()
            }
        }
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(UserConfig())
    }
}
