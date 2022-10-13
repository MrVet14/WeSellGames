//
//  ProfileButton.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct ProfileButton: View {
    
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        Image(systemName: "person")
            .padding(5)
            .foregroundColor(.white)
            .background(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
            .cornerRadius(50)
//            .onTapGesture {
//                impactLight.impactOccurred()
//            }
    }
}

struct ProfileButton_Previews: PreviewProvider {
    static var previews: some View {
        ProfileButton()
    }
}
