//
//  Orders.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/13/22.
//

import Foundation
import Firebase

class Orders: ObservableObject {
    @Published var orders: [Order] = []
    
    func addData(email: String, order: [Product], total: Double) {
        let userUID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        let orderID = UUID()
        //creating order doc
        db.collection("Users").document(userUID ?? "0").collection("Orders").document("\(orderID)").setData([
            "email" : email,
            "total" : total
        ]) { error in
            if error == nil {
                //parsing order items
                for prod in order {
                    db.collection("Users").document(userUID ?? "").collection("Orders").document("\(orderID)").collection("Order").document("\(prod.name)").setData([
                        "price": prod.price,
                        "quantity": prod.quantity,
                        "image": prod.image
                    ]) { error in
                        if error != nil { print(error?.localizedDescription ?? "") }
                    }
                }
                //Updating orders array
                self.getData()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    // FIX: Does not updates properly after switching accounts
    func getData() {
        orders.removeAll()
        let userUID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        
        db.collection("Users").document(userUID ?? "0").collection("Orders").getDocuments { [weak self] snapshot, error in
            if error == nil { 
                if let snapshot = snapshot {
                    for d in snapshot.documents {
                        self?.orders += [Order(id: d.documentID,
                                               email: d["email"] as? String ?? "",
                                               orderedProducts: [],
                                               total: d["total"] as? Double ?? 0)]
                        for i in 0..<(self?.orders.count ?? 0) {
                            if self?.orders[i].id == d.documentID {
                                db.collection("Users").document(userUID ?? "").collection("Orders").document("\(d.documentID)").collection("Order").getDocuments { snapshot2, error in
                                    if error == nil {
                                        if let snapshot2 = snapshot2 {
                                            for p in snapshot2.documents {
                                                self?.orders[i].orderedProducts += [Order.Products(id: UUID(),
                                                                                                   name: p.documentID,
                                                                                                   price: p["price"] as? Double ?? 0,
                                                                                                   quantity: p["quantity"] as? Int ?? 0,
                                                                                                   image: p["image"] as? String ?? "")]
                                            }
                                        }
                                    } else { print(error?.localizedDescription ?? "") }
                                }
                            }
                        }
                    }
                }
            } else { print(error?.localizedDescription ?? "") }
        }
    }
    
    func deleteData(order: Order) {
        let userUID = Auth.auth().currentUser?.uid
        let db = Firestore.firestore()
        
        db.collection("Users").document(userUID ?? "0").collection("Orders").document("\(order.id)").delete { [weak self] error in
            if error == nil {
                self?.getData()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
}

//class Orders: ObservableObject {
//    @Published var orders: [Order] = []
//
//    func addData(email: String, order: [Product], total: Double) {
//        let db = Firestore.firestore()
//        let orderID = UUID()
//        //creating order doc
//        db.collection("Orders").document("\(orderID)").setData([
//            "email" : email,
//            "total" : total
//        ]) { error in
//            if error == nil {
//                //parsing order items
//                for prod in order {
//                    db.collection("Orders").document("\(orderID)").collection("Order").document("\(prod.name)").setData([
//                        "price": prod.price,
//                        "quantity": prod.quantity,
//                        "image": prod.image
//                    ]) { error in
//                        if error != nil { print(error?.localizedDescription ?? "") }
//                    }
//                }
//                //Updating orders array
//                self.getData()
//            } else {
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
//
//    func getData() {
//        orders.removeAll()
//        let db = Firestore.firestore()
//
//        db.collection("Orders").getDocuments { [weak self] snapshot, error in
//            if error == nil {
//                if let snapshot = snapshot {
//                    for d in snapshot.documents {
//                        self?.orders += [Order(id: d.documentID,
//                                               email: d["email"] as? String ?? "",
//                                               orderedProducts: [],
//                                               total: d["total"] as? Double ?? 0)]
//                        for i in 0..<(self?.orders.count)! {
//                            if self?.orders[i].id == d.documentID {
//                                db.collection("Orders").document("\(d.documentID)").collection("Order").getDocuments { snapshot2, error in
//                                    if error == nil {
//                                        if let snapshot2 = snapshot2 {
//                                            for p in snapshot2.documents {
//                                                self?.orders[i].orderedProducts += [Order.Products(id: UUID(),
//                                                                                                   name: p.documentID,
//                                                                                                   price: p["price"] as? Double ?? 0,
//                                                                                                   quantity: p["quantity"] as? Int ?? 0,
//                                                                                                   image: p["image"] as? String ?? "")]
//                                            }
//                                        }
//                                    } else { print(error?.localizedDescription ?? "") }
//                                }
//                            }
//                        }
//                    }
//                }
//            } else { print(error?.localizedDescription ?? "") }
//        }
//    }
//
//    func deleteData(order: Order) {
//        let db = Firestore.firestore()
//
//        db.collection("Orders").document("\(order.id)").delete { [weak self] error in
//            if error == nil {
//                self?.getData()
//            } else {
//                print(error?.localizedDescription ?? "")
//            }
//        }
//    }
//}
