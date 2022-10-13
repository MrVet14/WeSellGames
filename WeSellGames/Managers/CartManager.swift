//
//  CartManager.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import Foundation

class CartManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var total: Double = 0
    
    func addToCart(product: Product) {
        if products.isEmpty {
            products.append(product)
            products[0].quantity += 1
            total += product.price
            return
        }
        
        for i in 0..<products.count {
            if products[i].name == product.name {
                products[i].quantity += 1
                total += product.price
                return
            } else if i == (products.count - 1) && products[i].name != product.name {
                products.append(product)
                products[i + 1].quantity += 1
                total += product.price
                return
            }
        }
    }
    
    func addingToQuantity(product: Product) {
        for i in 0..<products.count {
            if products[i].name == product.name {
                products[i].quantity += 1
                total += product.price
                return
            }
        }
    }
    
    func subtractFromQuantity(product: Product) {
        for i in 0..<products.count {
            if products[i].name == product.name {
                if products[i].quantity == 1 {
                    removeFormCart(product: product)
                    return
                } else {
                    products[i].quantity -= 1
                    total -= products[i].price
                    return
                }
            }
        }
    }
    
    func removeFormCart(product: Product) {
        for i in 0..<products.count {
            if products[i].name == product.name {
                total -= products[i].price * Double(products[i].quantity)
                products.remove(at: i)
                return
            }
        }
    }
}
