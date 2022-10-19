//
//  UserConfig.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import SwiftUI
import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import GoogleSignInSwift

class UserConfig: ObservableObject {
    let auth = Auth.auth()
    @Published var isAnonymous = true
    @Published var signedIn = false
    @Published var user = User(id: "", email: "")
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func anonymousAcc() {
        auth.signInAnonymously { [weak self] result, error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.user.id = result?.user.uid ?? ""
                    self?.signedIn = true
                    self?.isAnonymous = true
                }
                //Create new database entry for new user
                let db = Firestore.firestore()
                db.collection("Users").document(result?.user.uid ?? "").setData(["email" : "anon"])
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func singIn(_ email: String, _ password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if error == nil && result != nil {
                DispatchQueue.main.async {
                    self?.user.id = result?.user.uid ?? ""
                    self?.user.email = email
                    self?.signedIn = true
                    self?.isAnonymous = false
                }
                //Updating orders
                Orders().getData()
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func register(_ email: String, _ password: String) {
        print(isSignedIn)
        print(isAnonymous)
        
        if !isSignedIn && isAnonymous {
            auth.createUser(withEmail: email, password: password) { [weak self] result, error in
                if error == nil && result != nil {
                    DispatchQueue.main.async {
                        self?.user.id = result?.user.uid ?? ""
                        self?.user.email = email
                        self?.signedIn = true
                        self?.isAnonymous = false
                    }
                    //Create new database entry for new user
                    let db = Firestore.firestore()
                    db.collection("Users").document(result?.user.uid ?? "").setData(["email" : email])
                    //Updating orders
                    Orders().getData()
                } else {
                    print(error?.localizedDescription ?? "")
                }
            }
        } else {
            let user = Auth.auth().currentUser
            let credential = EmailAuthProvider.credential(withEmail: email, password: password)
            user?.link(with: credential) { [weak self] result, error in
                if error != nil {
                    print(error?.localizedDescription ?? "")
                } else {
                    DispatchQueue.main.async {
                        self?.user.id = result?.user.uid ?? ""
                        self?.user.email = email
                        self?.signedIn = true
                        self?.isAnonymous = false
                    }
                    //Add Email to the existing entry
                    let db = Firestore.firestore()
                    db.collection("Users").document(result?.user.uid ?? "").setData(["email" : email])
                }
            }
        }
        
    }
    
    func signOut() {
        try? auth.signOut()
        DispatchQueue.main.async {
            self.signedIn = false
            self.isAnonymous = true
            self.user.email = ""
        }
    }
    
    func getUserData() {
        if let user = Auth.auth().currentUser {
            DispatchQueue.main.async {
                self.user.id = user.uid
                self.user.email = user.email ?? ""
                self.isAnonymous = user.isAnonymous
            }
        }
    }
    
    func deleteAcc(_ password: String) {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(withEmail: self.user.email, password: password)

        user?.reauthenticate(with: credential) { [weak self] result, error in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                user?.delete { error in
                    if let error = error {
                        print(error.localizedDescription)
                    } else {
                        DispatchQueue.main.async {
                            self?.signedIn = false
                            self?.isAnonymous = true
                        }
                        
                        let db = Firestore.firestore()
                        db.collection("Users").document(user?.uid ?? "").delete()
                    }
                }
            }
        }
    }

//    func googleSignIn() {
//        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
//
//        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)
//
//        // Start the sign in flow!
//        GIDSignIn.sharedInstance.signIn(with: config, presenting: self) { [unowned self] user, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//
//            guard
//                let authentication = user?.authentication,
//                let idToken = authentication.idToken
//            else {
//                return
//            }
//
//            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                         accessToken: authentication.accessToken)
//
//            Auth.auth().signIn(with: credential) { result, error in
//                if let error = error {
//                    print(error.localizedDescription)
//                    return
//                }
//
//                DispatchQueue.main.async {
//                    self?.signedIn = true
//                    getUserData()
//                }
//
//                guard let user = result.user else { return }
//                print(user)
//            }
//        }
//    }
}

//extension View{
//    func getRootViewController() -> UIViewController {
//        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
//            return .init()
//        }
//        
//        guard let root = screen.windows.first?.rootViewController else {
//            return .init()
//        }
//        
//        return root
//    }
//}
