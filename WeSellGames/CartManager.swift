//
//  CartManager.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Double = 0
    
    func addToCart(product: Product) {
        products.append(product)
        total += product.price
    }
    
    func removeFormCart(product: Product) {
        products = products.filter { $0.id != product.id }
        total -= product.price
    }
}
