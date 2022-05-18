//
//  HomeView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 12/05/22.
//

import SwiftUI

struct MessagesListHomeView: View {
    
    @ObservedObject var viewModel:MessageViewModel
    @State var showLogoutOption:Bool = false
    @State var shouldShowNewMessageScreen:Bool = false
    
    var body: some View {
        if viewModel.isSignOut {
            LoginView(viewModel: LoginViewModel(firebaseManager: viewModel.firebaseManager))
        }else {
            NavigationView {
                VStack {
                    if !viewModel.errorMsg.isEmpty {
                        Text(viewModel.errorMsg).foregroundColor(.red)
                    }
                    CustomNavBar(showLogoutOption: $showLogoutOption,username: $viewModel.user.email, profileImageUrl: $viewModel.user.profileImageUrl)
                        .actionSheet(isPresented: $showLogoutOption) {
                            .init(title: Text("Settings"), message: Text("What do you want to do?"), buttons: [
                                .destructive(Text("Sign Out"), action: {
                                    viewModel.signOut()
                                }),
                                .cancel()
                            ])
                        }
                    listView()
                }.overlay(newMessageButton(),alignment: .bottom)
                .navigationBarHidden(true)
            }.onAppear {
                viewModel.fetchCurrentUser()
            }
        }
    }
    
    
    fileprivate func listView() -> some View {
        return ScrollView {
            ForEach(0..<10,id:\.self) { id in
                MessageCellView(user: User(email: "dummy@gmail.com", profileImageUrl: "", id: "\(id)"),showUsersOnly: false)
            }
        }.padding(.bottom,50)
    }
    
    fileprivate func newMessageButton() -> some View {
        return Button {
            shouldShowNewMessageScreen.toggle()
        } label: {
            HStack {
                Spacer()
                Text("+ New Message")
                    .font(.system(size: AppFont.FontSize.medium,weight: .bold))
                Spacer()
            }
            .foregroundColor(AppColor.white)
            .padding(.vertical)
            .background(AppColor.blue)
            .cornerRadius(32)
            .padding(.horizontal)
            .shadow(radius: 15)
        }
        .fullScreenCover(isPresented: $shouldShowNewMessageScreen) {
            NewMessageView(viewModel: NewMessageViewModel(firebaseManager: viewModel.firebaseManager))
        }
    }
}
