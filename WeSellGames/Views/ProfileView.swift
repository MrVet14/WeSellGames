//
//  ProfileView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userConfig: UserConfig
    
    var body: some View {
        VStack {
            Text("Profile is Empty")
            
            Button {
                userConfig.signOut()
            } label: {
                Text("Sign out")
                    .padding()
                    .foregroundColor(.red)
            }
        }
        .navigationTitle("My Profile")
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
