//
//  Register.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import SwiftUI

struct Register: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userConfig: UserConfig
    @State private var email: String = ""
    @State private var password: String = ""
    
    let haptic = UINotificationFeedbackGenerator()
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 0.919, green: 0.177, blue: 0.991), Color(red: 0.377, green: 0.816, blue: 0.879)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
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
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                        .keyboardType(.emailAddress)
                    
                    SecureField("Password", text: $password)
                        .autocorrectionDisabled()
                        .textInputAutocapitalization(.never)
                        .padding()
                        .background(.ultraThinMaterial)
                        .cornerRadius(10)
                    
                    Button {
                        if !email.isEmpty && !password.isEmpty {
                            haptic.notificationOccurred(.success)
                            userConfig.register(email, password)
                            if userConfig.isAnonymous {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text("Register")
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
                        SignIn()
                            .environmentObject(userConfig)
                    } label: {
                        Text("Already have an account? Sign in")
                            .foregroundColor(.accentColor)
                    }
                    .padding(.top, 10)
                    
                    Text("By creating account, you are agreeing to our Terms of Service")
                        .font(.body.bold())
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding()
        .navigationTitle("Register")
        }
    }
}

struct Register_Previews: PreviewProvider {
    static var previews: some View {
        Register()
            .environmentObject(UserConfig())
    }
}
