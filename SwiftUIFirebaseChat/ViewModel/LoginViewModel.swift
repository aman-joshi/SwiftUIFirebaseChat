//
//  LoginViewModel.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import Foundation
import SwiftUI

class LoginViewModel:ObservableObject {
    
    var firebaseManager:FirebaseManagerProtocol
    @Published var loginStatusMessage = ""
    @Published var isLoggedIn = false
    
    init(firebaseManager:FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }
    
    func createNewAccount(withEmail email:String,password:String,imageData:Data) {
        firebaseManager.createNewAccount(withEmail: email, password: password) { [weak self] user, err in
            if let _ = err {
                self?.loginStatusMessage = "Failed to create user"
                return
            }
            self?.loginStatusMessage = "Successfully created user: \(user ?? "NIL")"
            self?.saveImage(data: imageData, email: email)
        }
    }
    
    func logInUser(withEmail email:String,password:String) {
        firebaseManager.logInUser(withEmail: email, password: password) { [weak self] user, err in
            if let _ = err {
                self?.loginStatusMessage = "Failed to Log In user"
                return
            }
            self?.loginStatusMessage = "Successfully Log In user: \(user ?? "NIL")"
            self?.isLoggedIn = true
        }
    }
    
    private func saveImage(data:Data,email:String) {
       firebaseManager.persistImageToStorage(withFileName: "", imageData: data) { [weak self] err in
            if let _ = err {
                self?.loginStatusMessage = "Failed to upload image"
                return
            }
            
           self?.firebaseManager.downloadImageURL { [weak self] url, err in
                if let _ = err {
                    self?.loginStatusMessage = "Failed to download url"
                    return
                }
                self?.loginStatusMessage = "Successfully downloaded Image url: \(url!.absoluteString)"
               if let userInfo = self?.createUserData(withEmail: email, profileImageUrl: url!) {
                   self?.storeUser(info:userInfo)
               }else {
                   self?.loginStatusMessage = "Invalid data found can't save info"
               }
            }
        }
    }
    
    func createUserData(withEmail email:String,profileImageUrl:URL) -> JSON? {
        guard let uid = firebaseManager.currentUserId else {return nil}
        let userInfo = ["email":email,"uid":uid,"profileImageUrl":profileImageUrl.absoluteString]
        return userInfo
    }
    
   private func storeUser(info:JSON) {
        firebaseManager.storeUser(info: info) { [weak self] err in
            if let _ = err {
                self?.loginStatusMessage = "Failed to save user data"
                return
            }
            self?.loginStatusMessage = "Successfully save user data: \(info)"
            self?.isLoggedIn = true
        }
    }
}
