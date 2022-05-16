//
//  NewMessageView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 16/05/22.
//

import SwiftUI

struct NewMessageView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<10) { _ in
                    MessageCellView()
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
        }
    }
}
