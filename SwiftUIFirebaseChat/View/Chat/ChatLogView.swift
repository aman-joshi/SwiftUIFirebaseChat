//
//  ChatLogView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 03/06/22.
//

import SwiftUI

struct ChatLogView: View {
    
    let user:User
    
    var body: some View {
        ScrollView {
            ForEach(0..<10) { _ in
                Text("Fake messages!!")
            }
        }.navigationBarTitle(user.email, displayMode: .inline)
    }
}
