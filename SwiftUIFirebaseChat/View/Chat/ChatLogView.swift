//
//  ChatLogView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 03/06/22.
//

import SwiftUI

struct ChatLogView: View {
    
    let user:User
    @State private var msg:String = ""
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(0..<10) { _ in
                    HStack {
                        Spacer()
                        HStack {
                            Text("Fake messages!!")
                                .foregroundColor(.white)
                        }.padding()
                            .background(Color.blue)
                            .cornerRadius(8.0)
                    }
                    .padding(.horizontal)
                    .padding(.top,8)
                }
                HStack { Spacer() }
            }
            .background(Color(.init(white: 0.95, alpha: 1.0)))
            chatBottomBar()
        }
        .navigationBarTitle(user.email, displayMode: .inline)
    }
    
    fileprivate func chatBottomBar() -> some View {
        return HStack(spacing:16) {
            Image(systemName: "photo.on.rectangle")
                .font(.system(size: 24))
                .foregroundColor(Color(.darkGray))
            TextField("Description", text: $msg)
            Button {
                //
            } label: {
                Text("Send")
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
            .padding(.vertical,8)
            .background(Color.blue)
            .cornerRadius(4.0)
        }
        .padding(.horizontal)
        .padding(.vertical,8)
    }
}
