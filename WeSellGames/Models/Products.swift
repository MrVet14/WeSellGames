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
    @Published var retrievedProductImages = [String: URL]()
    
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
                        DispatchQueue.global(qos: .userInteractive).async {
                            self.getPhotos()
                        }
                    }
                }
            } else {
                print(error ?? "")
            }
        }
    }
    
    func getPhotos() {
        var paths = [String]()
        //Getting paths for Images
        for path in productList {
            paths.append("images/\(path.image).jpg")
            for ldPath in path.landImages {
                paths.append("images/\(ldPath).jpg")
            }
        }
        //looping through each file path to fetch data
        for path in paths {
            //Reference to storage
            let storageRef = Storage.storage().reference()
            //specifying the path
            let fileRef = storageRef.child(path)
            //Retrieving Data
            fileRef.downloadURL { url, error in
                if error == nil && url != nil {
                    DispatchQueue.main.async {
                        self.retrievedProductImages[path.replacingOccurrences(of: "images/", with: "").replacingOccurrences(of: ".jpg", with: "")] = url
                    }
                }
            }
        } //End Path loop
    }
    
}
