//
//  Products.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/10/22.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseStorage

class Products: ObservableObject {
    @Published private(set) var productList = [Product]()
    @Published private(set) var retrievedProductImages = [UIImage]()
    //@Published private(set) var dicOfRtvPic = [String: Int]()
    
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
//                        DispatchQueue.global(qos: .userInteractive).async {
//                            self.getPhotos()
//                        }
                    }
                }
            } else {
                print(error ?? "")
            }
        }
    }
    
//    func getPhotos() {
//        var paths = [String]()
//        //Getting paths for Images
//        for path in productList {
//            paths.append("images/\(path.image).jpg")
//            for ldPath in path.landImages {
//                paths.append("images/\(ldPath).jpg")
//            }
//        }
//        print(paths)
//        //looping through each file path to fetch data
//        for path in paths {
//            //Reference to storage
//            let storageRef = Storage.storage().reference()
//            //specifying the path
//            let fileRef = storageRef.child(path)
//            //Retrieving Data
//            fileRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
//                if error == nil && data != nil {
//                    //Creating UIImage and putting it in retrievedProductImages array
//                    if let image = UIImage(data: data!) {
//                        //Putting image onto main thread
//                        DispatchQueue.main.async {
//                            self.retrievedProductImages.append(image)
//                        }
//                    }
//                } else {
//                    print(error ?? "")
//                }
//            }
//        } //End Path loop
//    }
    
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


//func getPhotos() {
//    var numberOfPathEntry = 0
//
//    var paths = [String]()
//    //Getting paths for Images
//    for path in productList {
//        paths.append("images/\(path.image).jpg")
//        for ldPath in path.landImages {
//            paths.append("images/\(ldPath).jpg")
//        }
//    }
//    print(paths)
//    //looping through each file path to fetch data
//    for path in paths {
//        //Reference to storage
//        let storageRef = Storage.storage().reference()
//        //specifying the path
//        let fileRef = storageRef.child(path)
//        //Retrieving Data
//        fileRef.getData(maxSize: 4 * 1024 * 1024) { data, error in
//            if error == nil && data != nil {
//                //Creating UIImage and putting it in retrievedProductImages array
//                if let image = UIImage(data: data!) {
//                    self.dicOfRtvPic[path] = numberOfPathEntry
//                    numberOfPathEntry += 1
//                    //Putting image onto main thread
//                    DispatchQueue.main.async {
//                        self.retrievedProductImages.append(image)
//                        print("Path: \(path)")
//                        print("New Entry: \(self.retrievedProductImages)")
//                    }
//                    print("dic value:\(self.dicOfRtvPic)")
//                }
//            } else {
//                print(error ?? "")
//            }
//        }
//    } //End Path loop
//}
