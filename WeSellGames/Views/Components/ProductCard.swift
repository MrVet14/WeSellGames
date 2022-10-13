//
//  ProductCard.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var products: Products
    var product: Product
    @State private var showingSheet = false
    
    let impactMedium = UIImpactFeedbackGenerator(style: .medium)
    let hapticSelection = UISelectionFeedbackGenerator()
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            ZStack(alignment: .bottom) {
                WebImage(url: products.retrievedProductImages["\(product.image)"])
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 180)
                    .scaledToFit()
                
                VStack(alignment: .leading) {
                    Text(product.name)
                        .bold()
                        .lineLimit(2)
                    
                    Text("\(product.price.formatted(.currency(code: "USD")))")
                        .font(.caption)
                }
                .padding()
                .frame(width: 180, alignment: .leading)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
            }
            .frame(width: 180, height: 250)
            .shadow(radius: 4)
            .onTapGesture {
                hapticSelection.selectionChanged()
                showingSheet.toggle()
            }
            .sheet(isPresented: $showingSheet, onDismiss: { hapticSelection.selectionChanged() }) {
                ProductCartTappedView(product: product)
            }
            
            Button {
                impactMedium.impactOccurred()
                cartManager.addToCart(product: product)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product(name: "Surviving Mars", image: "survivingMars", landImages: ["survivingMars-land1", "survivingMars-land2", "survivingMars-land3"], description: "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process.", price: 20.0))
            .environmentObject(CartManager())
            .environmentObject(Products())
    }
}
