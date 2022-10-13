//
//  CartButton.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct CartButton: View {
    @EnvironmentObject var cartManager: CartManager
    
    let impactLight = UIImpactFeedbackGenerator(style: .light)
    
    var body: some View {
        HStack {
            ZStack(alignment: .topTrailing) {
                Image(systemName: "cart")
                    .padding(.top, 5)
                
                if cartManager.products.count != 0 {
                    Text("\(cartManager.products.count)")
                        .font(.caption2).bold()
                        .foregroundColor(.white)
                        .frame(width: 15, height: 15)
                        .background(Color(hue: 0.592, saturation: 0.683, brightness: 0.703))
                        .cornerRadius(50)
                }
            }
            
            if cartManager.products.count != 0 {
                Text("\(cartManager.total.formatted(.currency(code: "USD")))")
                    .foregroundColor(.primary)
                    .padding(1)
                    .background(Color(hue: 0.592, saturation: 0.683, brightness: 0.703))
                    .cornerRadius(20)
            }
        }
        .onTapGesture {
            impactLight.impactOccurred()
        }
    }
}

struct CartButton_Previews: PreviewProvider {
    static var previews: some View {
        CartButton()
            .environmentObject(CartManager())
    }
}
