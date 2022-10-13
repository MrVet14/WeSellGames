//
//  Carousel.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/9/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct Carousel: View {
    @EnvironmentObject var products: Products
    
    var product: Product
    @State private var index = 0
    
    var body: some View {
        VStack{
            TabView(selection: $index) {
                ForEach((0..<product.landImages.count), id: \.self) { index in
                    WebImage(url: products.retrievedProductImages["\(product.landImages[index])"])
                        .resizable()
                        .frame(height: 250)
                        .cornerRadius(10)
                        .scaledToFit()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
        }
        .frame(height: 250)
    }
}

struct Carousel_Previews: PreviewProvider {
    static var previews: some View {
        Carousel(product: Product(name: "Surviving Mars", image: "survivingMars", landImages: ["survivingMars-land1", "survivingMars-land2", "survivingMars-land3"], description: "Surviving Mars is a sci-fi city builder all about colonizing Mars and surviving the process.", price: 20.0, genre: "Simulator"))
    }
}
