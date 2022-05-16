//
//  SwiftUIFirebaseChatApp.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import SwiftUI

@main
struct SwiftUIFirebaseChatApp: App {
    private let firebaseManager:FirebaseManager
    
    init() {
        firebaseManager = FirebaseManager()
    }
    
    var body: some Scene {
        WindowGroup {
            if firebaseManager.currentUserId == nil {
                LoginView(viewModel: LoginViewModel(firebaseManager:firebaseManager))
            }else {
                MessagesListHomeView(viewModel: MessageViewModel(firebaseManager: firebaseManager))
            }
        }
    }
}
