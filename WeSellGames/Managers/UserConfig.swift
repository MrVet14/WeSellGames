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
    
    @Published var signedIn = false
    @Published var user = User(email: "")
    
    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    
    func singIn(_ email: String, _ password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            if error == nil && result != nil {
                DispatchQueue.main.async {
                    self?.user.email = email
                    self?.signedIn = true
                }
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func register(_ email: String, _ password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if error == nil && result != nil {
                DispatchQueue.main.async {
                    self?.user.email = email
                    self?.signedIn = true
                }
            } else {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        DispatchQueue.main.async {
            self.signedIn = false
            self.user.email = ""
        }
    }
    
    func getUserData() {
        let user = Auth.auth().currentUser
        
        if let user = user {
            let email = user.email
            DispatchQueue.main.async {
                self.user.email = email ?? "test"
            }
        }
    }
    
    func deleteAcc() {
        let user = Auth.auth().currentUser
            
        user?.delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                DispatchQueue.main.async {
                    self.signedIn = false
                    self.user.email = ""
                }
            }
        }
    
    }
         
//    func deleteAcc(_ password: String) {
//        let user = Auth.auth().currentUser
//        let credential: AuthCredential = EmailAuthProvider.credential(withEmail: self.user.email, password: password)
//        user?.reauthenticate(with: credential) { err, arg  in
//            if err != nil {
//                print(err ?? "")
//            } else {
//                user?.delete { error in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    } else {
//                        DispatchQueue.main.async {
//                            self.signedIn = false
//                            self.user.email = ""
//                        }
//                    }
//                }
//            }
//        }
//
//    }
    
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

// Code for updating credentials in order to delete acc

//let user = Auth.auth().currentUser
//var credential: AuthCredential
//
//// Prompt the user to re-provide their sign-in credentials
//
//user?.reauthenticate(with: credential) { error in
//  if let error = error {
//    // An error happened.
//  } else {
//    // User re-authenticated.
//  }
//}
