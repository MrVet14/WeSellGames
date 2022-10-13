//
//  CheckOutButton.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import SwiftUI

struct CheckOutButton: View {
    var body: some View {
        Text("Check Out")
            .font(.title)
            .fontWeight(.medium)
            .foregroundColor(Color(hue: 0.519, saturation: 0.683, brightness: 0.703))
            .padding()
            .frame(maxWidth: .infinity)
            .background(.ultraThinMaterial)
            .cornerRadius(20)
    }
}

struct CheckOutButton_Previews: PreviewProvider {
    static var previews: some View {
        CheckOutButton()
    }
}
