//
//  CartManager.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/8/22.
//

import Foundation
import Firebase

class CartManager: ObservableObject {
    @Published var products: [Product] = []
    @Published var total: Double = 0
    
    let db = Firestore.firestore()
    
    func addToCart(product: Product) {
        if products.isEmpty {
            addingToDB(product)
            return
        }
        
        for i in 0..<products.count {
            if products[i].name == product.name {
                let quantity = products[i].quantity + 1
                updateQuantityInProductInCartInDB(product, quantity)
                return
            } else if i == (products.count - 1) && products[i].name != product.name {
                addingToDB(product)
                return
            }
        }
    }
    
    func addingToQuantity(product: Product) {
        for i in 0..<products.count {
            if products[i].name == product.name {
                let quantity = products[i].quantity + 1
                updateQuantityInProductInCartInDB(product, quantity)
                return
            }
        }
    }
    
    func subtractFromQuantity(product: Product) {
        for i in 0..<products.count {
            if products[i].name == product.name {
                if products[i].quantity == 1 {
                    removeFromDB(product)
                    return
                } else {
                    let quantity = products[i].quantity - 1
                    updateQuantityInProductInCartInDB(product, quantity)
                    return
                }
            }
        }
    }
    
    func removeFormCart(product: Product) {
        for i in 0..<products.count {
            if products[i].name == product.name {
                removeFromDB(product)
                return
            }
        }
    }
    
    func cartHasBeenCheckedOut() {
        removeCart()
    }
    
    func getCart() {
        products.removeAll()
        total = 0
        let userUID = Auth.auth().currentUser?.uid
        
        db.collection("Users").document(userUID ?? "0").collection("Cart").getDocuments { [weak self] snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    DispatchQueue.main.async {
                        for d in snapshot.documents {
                            self?.products += [Product(id: UUID(),
                                                       name: d.documentID,
                                                       image: d["image"] as? String ?? "",
                                                       landImages: [],
                                                       description: "",
                                                       price: d["price"] as? Double ?? 0,
                                                       quantity: d["quantity"] as? Int ?? 1,
                                                       genre: "")]
                        }
                        if !(self?.products.isEmpty ?? true) {
                            for i in 0..<(self?.products.count ?? 0) {
                                self?.total += (self?.products[i].price ?? 0) * Double((self?.products[i].quantity ?? 1))
                            }
                        } 
                    }
                }
            } else { print(error?.localizedDescription ?? "") }
        }
    }
    
    func addingToDB(_ product: Product) {
        let userUID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userUID ?? "0").collection("Cart").document(product.name).setData(["image": product.image,
                                                                                                           "quantity": 1,
                                                                                                           "price": product.price])
        getCart()
    }
    
    func removeFromDB(_ product: Product) {
        let userUID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userUID ?? "0").collection("Cart").document(product.name).delete()
        getCart()
    }
    
    func updateQuantityInProductInCartInDB(_ product: Product, _ quantity: Int) {
        let userUID = Auth.auth().currentUser?.uid
        db.collection("Users").document(userUID ?? "0").collection("Cart").document(product.name).updateData(["quantity": quantity])
        getCart()
    }
    
    func removeCart() {
        let userUID = Auth.auth().currentUser?.uid
        for p in products {
            db.collection("Users").document(userUID ?? "0").collection("Cart").document(p.name).delete()
        }
        getCart()
    }
}

//class CartManager: ObservableObject {
//    @Published var products: [Product] = []
//    @Published var total: Double = 0
//
//    func addToCart(product: Product) {
//        if products.isEmpty {
//            products.append(product)
//            products[0].quantity += 1
//            total += product.price
//            return
//        }
//
//        for i in 0..<products.count {
//            if products[i].name == product.name {
//                products[i].quantity += 1
//                total += product.price
//                return
//            } else if i == (products.count - 1) && products[i].name != product.name {
//                products.append(product)
//                products[i + 1].quantity += 1
//                total += product.price
//                return
//            }
//        }
//    }
//
//    func addingToQuantity(product: Product) {
//        for i in 0..<products.count {
//            if products[i].name == product.name {
//                products[i].quantity += 1
//                total += product.price
//                return
//            }
//        }
//    }
//
//    func subtractFromQuantity(product: Product) {
//        for i in 0..<products.count {
//            if products[i].name == product.name {
//                if products[i].quantity == 1 {
//                    removeFormCart(product: product)
//                    return
//                } else {
//                    products[i].quantity -= 1
//                    total -= products[i].price
//                    return
//                }
//            }
//        }
//    }
//
//    func removeFormCart(product: Product) {
//        for i in 0..<products.count {
//            if products[i].name == product.name {
//                total -= products[i].price * Double(products[i].quantity)
//                products.remove(at: i)
//                return
//            }
//        }
//    }
//
//    func cartHasBeenCheckedOut() {
//        self.products.removeAll()
//        self.total = 0
//    }
//
//}
