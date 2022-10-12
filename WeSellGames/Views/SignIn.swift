//
//  SignIn.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import SwiftUI

struct SignIn: View {
    @EnvironmentObject var userConfig: UserConfig
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Image("Icon")
                .resizable()
                .frame(width: 300, height: 300)
                .scaledToFit()
                .padding(.bottom, 60)
            
            VStack {
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                SecureField("Password", text: $password)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(10)
                
                Button {
                    if !email.isEmpty && !password.isEmpty {
                        userConfig.singIn(email, password)
                    }
                } label: {
                    Text("Sign in")
                        .font(.title2)
                        .padding()
                        .foregroundColor(.white)
                        .frame(width: 250)
                        .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                        .cornerRadius(10)
                }
                .padding(.top)
                .padding(.bottom, 5)

                NavigationLink {
                    Register()
                        .environmentObject(userConfig)
                } label: {
                    Text("Don't have an account? Register")
                        .foregroundColor(.accentColor)
                }
            }
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

//struct SignIn_Previews: PreviewProvider {
//    static var previews: some View {
//        SignIn()
//    }
//}
