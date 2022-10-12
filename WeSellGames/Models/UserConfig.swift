//
//  UserConfig.swift
//  WeSellGames
//
//  Created by Vitali Vyucheiski on 10/12/22.
//

import Foundation
import FirebaseAuth

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
                self?.user.email = email
                self?.signedIn = true
            } else {
                print(error ?? "")
            }
        }
    }
    
    func register(_ email: String, _ password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            if error == nil && result != nil {
                self?.user.email = email
                self?.signedIn = true
            } else {
                print(error ?? "")
            }
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
        self.user.email = ""
    }
}
