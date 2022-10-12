//
//  WelcomeScreen.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import SwiftUI

struct WelcomeScreen: View {
    @EnvironmentObject var userConfig: UserConfig
//    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView {
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
                    Text("Wanna check out?")
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
                    
//                    Button {
//                        isPresented.toggle()
//                    } label: {
//                        Text("Continue as a guest")
//                            .foregroundColor(.accentColor)
//                    }
//                    .padding()
                }
            }
            .padding()
        }
    }
}

//struct WelcomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeScreen(isPresented: true)
//    }
//}
