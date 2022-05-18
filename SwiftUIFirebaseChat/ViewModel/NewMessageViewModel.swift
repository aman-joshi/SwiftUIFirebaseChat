//
//  NewMessageViewModel.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 16/05/22.
//

import Foundation

class NewMessageViewModel:ObservableObject {
    
    private(set) var firebaseManager:FirebaseManagerProtocol
    @Published var users:[User] = []
    
    init(firebaseManager:FirebaseManagerProtocol) {
        self.firebaseManager = firebaseManager
    }
    
    func fetchAllUsers() {
        Task {
            do {
                let users =  try await firebaseManager.fetchAllUsers()
                DispatchQueue.main.async {
                    self.users = users
                }
            }catch {
                print("Error - \(error.localizedDescription)")
            }
        }
    }
}
