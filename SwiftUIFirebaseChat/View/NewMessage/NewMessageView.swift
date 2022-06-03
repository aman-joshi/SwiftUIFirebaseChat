//
//  NewMessageView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 16/05/22.
//

import SwiftUI

struct NewMessageView: View {
    
    @ObservedObject var viewModel:NewMessageViewModel
    @Environment(\.presentationMode) var presentationMode
    let didSelectUser:(User) -> ()
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(viewModel.users) { user in
                    Button {
                        presentationMode.wrappedValue.dismiss()
                        didSelectUser(user)
                    } label: {
                        MessageCellView(user: user)
                    }
                }
            }.navigationBarTitle("New Message")
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Cancel")
                        }
                    }
                }
        }.onAppear {
            viewModel.fetchAllUsers()
        }
    }
}
