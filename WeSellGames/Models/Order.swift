//
//  Order.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import Foundation

struct Order: Identifiable {
    var id: String
    var email: String
    var orderedProducts: [Products]
    var total: Double
    
    struct Products: Identifiable {
        var id: UUID
        var name: String
        var price: Double
        var quantity: Int
        var image: String
    }
}
