//
//  Products.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/10/22.
//

import Foundation
import Firebase
import FirebaseFirestore

class Products: ObservableObject {
    @Published private(set) var productList = [Product]()
    
    func getData() {
        let db = Firestore.firestore()
        
        db.collection("GamesForSale").getDocuments { snapshot, error in
            //Check for errors
            if error == nil {
                //No errors here
                if let snapshot = snapshot {
                    //return to main thread
                    DispatchQueue.main.async {
                        //fetching data and putting it to listOfProducts array
                        for d in snapshot.documents {
                            let ldImg = d["landImages"] as? String ?? ""

                            self.productList += [Product(name: d["name"] as? String ?? "",
                                                    image: d["image"] as? String ?? "",
                                                    landImages: ldImg.components(separatedBy: "\\"),
                                                    description: d["description"] as? String ?? "",
                                                    price: d["price"] as? Double ?? 0)]
                        }
                    }
                }
            } else {
                print(error ?? "")
            }
        }
    }
    
}

//self.productList = snapshot.documents.map { d in
//    let name = d["name"] as? String ?? ""
//    let image = d["image"] as? String ?? ""
//    let description = d["description"] as? String ?? ""
//    let price = d["price"] as? Double ?? 0
//    //Creating unfiltered string of landscape pictures
//    let ldImg = d["landImages"] as? String ?? ""
//    let landImages = ldImg.components(separatedBy: "\\")
//    // create new item for each doc return
//    return Product(name: d["name"] as? String ?? "",
//                   image: d["image"] as? String ?? "",
//                   landImages: ldImg.components(separatedBy: "\\"),
//                   description: d["description"] as? String ?? "",
//                   price: d["price"] as? Double ?? 0)
//}

//for d in snapshot.documents {
//    var name = d["name"] as? String ?? ""
//    var image = d["image"] as? String ?? ""
//    var description = d["description"] as? String ?? ""
//    var price = d["price"] as? Double ?? 0
//
//    var ldImg = d["landImages"] as? String ?? ""
//    var landImages = ldImg.components(separatedBy: "\\")
//
//    self.productList += [Product(name: name,
//                            image: image,
//                            landImages: landImages,
//                            description: description,
//                            price: price)]
//    print("Data parsed")
//    print(self.productList)
//}
