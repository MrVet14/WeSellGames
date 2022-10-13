//
//  MainShopView.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import SwiftUI

struct MainShopView: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var products: Products
    @State private var activeCategory = "All"
    
    var productsToDisplay:[Product] {
        var toReturn = [Product]()
        
        if activeCategory == "All" {
            toReturn = products.productList
        } else {
            for prod in products.productList {
                if prod.genre == activeCategory {
                    toReturn.append(prod)
                }
            }
        }
        
        return toReturn
    }
    
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(products.categories, id: \.self) { category in
                        Button {
                            activeCategory = category
                        } label: {
                            Text(category)
                                .font(.body)
                                .padding(8)
                                .foregroundColor(category == activeCategory ? .primary : .secondary)
                                .background {
                                    Capsule()
                                        .strokeBorder(category == activeCategory ? Color(hue: 0.519, saturation: 0.683, brightness: 0.703) : Color(.secondarySystemBackground), lineWidth: 2)
                                }
                        }
                    }
                }
                .padding(.leading, 20)
                .padding(.top, 10)
            }
            
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productsToDisplay, id: \.id) { product in
                        ProductCard(product: product)
                            .environmentObject(cartManager)
                            .environmentObject(products)
                    }
                }
                .padding()
            }
        }
    }
}

struct MainShopView_Previews: PreviewProvider {
    static var previews: some View {
        MainShopView()
            .environmentObject(CartManager())
            .environmentObject(Products())
    }
}
