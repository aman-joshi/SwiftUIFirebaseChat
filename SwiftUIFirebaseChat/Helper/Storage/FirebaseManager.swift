//
//  FirebaseManager.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import Foundation
import Firebase
import FirebaseStorage

class FirebaseManager:NSObject {
    
    static let shared = FirebaseManager()
    let auth:Auth
    let storage:Storage
    
    private override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
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
    
    func persistImageToStorage(withFileName fileName:String,imageData:Data,completion:@escaping (Error?) -> Void) {
        guard let uid = self.auth.currentUser?.uid else {return}
        let ref = storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil) { metaData, err in
            completion(err)
        }
    }
    
    func downloadImageURL(completion:@escaping(URL?,Error?) -> Void) {
        guard let uid = self.auth.currentUser?.uid else {return}
        let ref = storage.reference(withPath: uid)
        ref.downloadURL { url, err in
            completion(url,err)
        }
    }
    
}
