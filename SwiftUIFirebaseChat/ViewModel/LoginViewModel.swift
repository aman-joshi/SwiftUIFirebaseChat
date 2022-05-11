//
//  LoginViewModel.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import Foundation
import SwiftUI

class LoginViewModel:ObservableObject {
    
    @Published var loginStatusMessage = ""
    
    func createNewAccount(withEmail email:String,password:String) {
        FirebaseManager.shared.createNewAccount(withEmail: email, password: password) { [weak self] user, err in
            if let err = err {
                print("failed to create user - ",err.localizedDescription)
                self?.loginStatusMessage = "Failed to create user"
                return
            }
            self?.loginStatusMessage = "Successfully created user: \(user ?? "NIL")"
            print("Successfully created user: \(user ?? "NIL")")
        }
    }
    
    func logInUser(withEmail email:String,password:String) {
        FirebaseManager.shared.logInUser(withEmail: email, password: password) { [weak self] user, err in
            if let err = err {
                print("failed to create user - ",err.localizedDescription)
                self?.loginStatusMessage = "Failed to Log In user"
                return
            }
            self?.loginStatusMessage = "Successfully Log In user: \(user ?? "NIL")"
            print("Successfully created user: \(user ?? "NIL")")
        }
    }
}
