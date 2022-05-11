//
//  SwiftUIFirebaseChatApp.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import SwiftUI

@main
struct SwiftUIFirebaseChatApp: App {
    private let loginVM = LoginViewModel()
    var body: some Scene {
        WindowGroup {
            LoginView(viewModel: loginVM)
        }
    }
}
