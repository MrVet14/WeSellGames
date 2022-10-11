//
//  Product.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var landImages: [String]
    var description: String
    var price: Double
}
