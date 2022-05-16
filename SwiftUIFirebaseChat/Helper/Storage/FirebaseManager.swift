//
//  FirebaseManager.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

typealias JSON = [String:Any]

protocol FirebaseManagerProtocol {
    func createNewAccount(withEmail email:String,password:String,completion:@escaping (String?,Error?) -> Void)
    func logInUser(withEmail email:String,password:String,completion:@escaping (String?,Error?) -> Void)
    func persistImageToStorage(withFileName fileName:String,imageData:Data,completion:@escaping (Error?) -> Void)
    func downloadImageURL(completion:@escaping(URL?,Error?) -> Void)
    func storeUser(info:JSON,completion:@escaping(Error?) -> Void)
    func fetchCurrentUser() async throws -> User
    var currentUserId: String? {get}
    func signOut() throws
}

final class FirebaseManager:NSObject,FirebaseManagerProtocol,ObservableObject {
    
    private let auth:Auth
    private let storage:Storage
    private let firestore:Firestore
    
    override init() {
        FirebaseApp.configure()
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }
    
    var currentUserId: String? {
        auth.currentUser?.uid
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
        guard let uid = self.currentUserId else {return}
        let ref = storage.reference(withPath: uid)
        ref.putData(imageData, metadata: nil) { metaData, err in
            completion(err)
        }
    }
    
    func downloadImageURL(completion:@escaping(URL?,Error?) -> Void) {
        guard let uid = self.currentUserId else {return}
        let ref = storage.reference(withPath: uid)
        ref.downloadURL { url, err in
            completion(url,err)
        }
    }
    
    func storeUser(info:JSON,completion:@escaping(Error?) -> Void) {
        guard let uid = self.currentUserId else {return}
        let collectionRef = firestore.collection(FirebaseCollectionRef.users)
        collectionRef.document(uid).setData(info) { err in
            completion(err)
        }
    }
    
    func fetchCurrentUser() async throws -> User {
        guard let uid = self.currentUserId else {return User() }
        let documentRef = firestore.collection(FirebaseCollectionRef.users).document(uid)
        do {
            let document =  try await documentRef.getDocument()
            if let json = document.data() {
                do {
                    let data = try json.toData()
                    let user = try JSONDecoder().decode(User.self, from: data)
                    return user
                }
            }
        }catch {
            throw error
        }
        return User()
    }
    
    func signOut() throws {
        do {
            try self.auth.signOut()
        }catch {
            throw error
        }
    }
}
