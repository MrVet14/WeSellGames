//
//  SignInWithGoogleButton.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct SignInWithGoogleButton: View {
    @EnvironmentObject var userConfig: UserConfig
    
    var body: some View {
        Button {
        
        } label: {
            HStack {
                Image("Google")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                
                Text("Sign In with Google")
                    .font(.title3)
                    .fontWeight(.medium)
                    .padding(.leading, 5)
            }
            .foregroundColor(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                Capsule()
                    .strokeBorder(Color(hue: 0.519, saturation: 0.683, brightness: 0.703), lineWidth: 2)
            }
        }
    }
}

struct SignInWithGoogleButton_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithGoogleButton()
            .environmentObject(UserConfig())
    }
}
