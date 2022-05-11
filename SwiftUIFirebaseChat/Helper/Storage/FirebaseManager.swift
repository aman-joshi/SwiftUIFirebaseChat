//
//  FirebaseManager.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import Foundation
import Firebase

class FirebaseManager:NSObject {
    
    static let shared = FirebaseManager()
    let auth:Auth
    
    private override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        super.init()
    }
    
    func createNewAccount(withEmail email:String,password:String,completion:@escaping (String?,Error?) -> Void) {
        auth.createUser(withEmail: email, password: password) { result, err in
            completion(result?.user.uid,err)
        }
    }
    
    func logInUser(withEmail email:String,password:String,completion:@escaping (String?,Error?) -> Void) {
        auth.signIn(withEmail: email, password: password) { result, err in
            completion(result?.user.uid,err)
        }
    }
    
}
