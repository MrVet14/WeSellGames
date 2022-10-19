//
//  SignInOrRegisterComponent.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/19/22.
//

import SwiftUI

struct SignInOrRegisterComponent: View {
    @EnvironmentObject var userConfig: UserConfig
    
    var body: some View {
        Text("Please, to continue:")
            .font(.title2)
        
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
//                            .onTapGesture {
//                                impactLight.impactOccurred()
//                            }
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
//                            .onTapGesture {
//                                impactLight.impactOccurred()
//                            }
            }
        }
    }
}

struct SignInOrRegisterComponent_Previews: PreviewProvider {
    static var previews: some View {
        SignInOrRegisterComponent()
    }
}
