//
//  ProductCartTappedView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/9/22.
//

import SwiftUI

struct ProductCartTappedView: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product
    
    let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Carousel(product: product)
                    .padding(.vertical, 15)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.title)
                        
                        HStack {
                            Text("\(product.price.formatted(.currency(code: "USD")))")
                                .font(.body).bold()
                            
                            Text("\(product.genre)")
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        impactMedium.impactOccurred()
                        cartManager.addToCart(product: product)
                    } label: {
                        Text("Add to cart")
                            .padding()
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(50)
                    }
                }
                
                Divider()
                
                Text("About: \(product.name)")
                    .font(.title2)
                Text(product.description)
            }
            .padding()
        }
    }
}

struct ProductCartTappedView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCartTappedView(product: Product(name: "Surviving Mars", image: "survivingMars", landImages: ["survivingMars-land1", "survivingMars-land2", "survivingMars-land3"], description: "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process.", price: 20.0, genre: "Simulator"))
            .environmentObject(CartManager())
    }
}
