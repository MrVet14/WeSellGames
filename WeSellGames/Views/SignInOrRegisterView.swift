//
//  SignInOrRegisterView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/19/22.
//

import SwiftUI

struct SignInOrRegisterView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userConfig: UserConfig
    @State var isSignInViewPresented: Bool
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
                            if isSignInViewPresented {
                                userConfig.singIn(email, password)
                            } else {
                                userConfig.register(email, password)
                            }
                            if userConfig.isAnonymous {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                        }
                    } label: {
                        Text(isSignInViewPresented ? "Sign In" : "Register")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.white)
                            .frame(width: 250)
                            .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
                            .cornerRadius(10)
                    }
                    .padding(.top)
                    .padding(.bottom, 5)

                    Button {
                        isSignInViewPresented.toggle()
                    } label: {
                        Text(isSignInViewPresented ? "Don't have an account? Register" : "Already have an account? Sign in")
                            .foregroundColor(.accentColor)
                    }
                    .padding(.top, 10)
                    
                    Text(isSignInViewPresented ? "Welcome Back :)" : "By creating account, you are agreeing to our Terms of Service")
                        .font(.body.bold())
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .padding()
        .navigationTitle(isSignInViewPresented ? "SignIn" : "Register")
        }
    }
}

struct SignInOrRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        SignInOrRegisterView(isSignInViewPresented: true)
            .environmentObject(UserConfig())
    }
}
