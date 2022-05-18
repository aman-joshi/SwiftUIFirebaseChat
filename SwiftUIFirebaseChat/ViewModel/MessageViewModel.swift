//
//  MessageViewModel.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 14/05/22.
//

import Foundation

class MessageViewModel:ObservableObject {
    
    private(set) var firebaseManager:FirebaseManagerProtocol
    @Published var user:User = User()
    @Published var errorMsg = ""
    @Published var isSignOut = false
    
    init(firebaseManager:FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }
    
    func fetchCurrentUser() {
        Task {
            do {
                let user =  try await firebaseManager.fetchCurrentUser()
                DispatchQueue.main.async {
                    self.user = user
                }
            }catch {
                print("Error - \(error.localizedDescription)")
            }
        }
    }
    
    func signOut() {
        do {
            try firebaseManager.signOut()
            isSignOut.toggle()
        }catch {
            errorMsg = error.localizedDescription
        }
    }
}
