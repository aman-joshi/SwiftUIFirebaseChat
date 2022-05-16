//
//  ContentView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 11/05/22.
//

import SwiftUI

struct LoginView: View {
    
    @State private var isLoginMode = false
    @State private var email = ""
    @State private var password = ""
    @State private var isShowPhotoLibrary = false
    @State private var image:UIImage?
    
    @ObservedObject var viewModel:LoginViewModel
    
    var body: some View {
        if viewModel.isLoggedIn {
            MessagesListHomeView(viewModel: MessageViewModel(firebaseManager: viewModel.firebaseManager))
        }else {
        NavigationView {
            ScrollView {
                VStack(spacing:16) {
                    pickerView()
                    if !isLoginMode {
                        Button {
                            self.isShowPhotoLibrary.toggle()
                        } label: {
                            VStack {
                                if let selectedImage = image {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 128, height: 128)
                                        .cornerRadius(64)
                                }else {
                                    Image(systemName: "person.fill")
                                        .font(.system(size: 64))
                                        .padding()
                                        .foregroundColor(AppColor.black)
                                }
                            }.overlay(Circle().stroke(Color(.label), lineWidth: 2.0))
                        }
                    }
                    inputFields()
                    Button {
                        if isLoginMode {
                            viewModel.logInUser(withEmail: email, password: password)
                        }else {
                            if let imageData = image?.jpegData(compressionQuality: 0.5) {
                                viewModel.createNewAccount(withEmail: email, password: password,imageData: imageData)
                            }
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text( isLoginMode ? Constants.login : Constants.createAccount)
                                .foregroundColor(AppColor.white)
                                .padding(.vertical,10)
                                .cornerRadius(5.0)
                                .font(.system(size: AppFont.FontSize.small, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                    Text(viewModel.loginStatusMessage).foregroundColor(AppColor.red)
                        .frame(maxWidth:.infinity,alignment: .leading)
                       
                }.padding()
            }
            .navigationTitle( isLoginMode ? Constants.login : Constants.createAccount)
            .background(Color(.init(white: 0, alpha: 0.05)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $isShowPhotoLibrary, onDismiss: nil) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
        }
    }
    
    fileprivate func pickerView() -> some View {
        return Picker(selection: $isLoginMode, label: Text("Picker")) {
            Text(Constants.login).tag(true)
            Text(Constants.createAccount).tag(false)
        }.pickerStyle(SegmentedPickerStyle())
    }
    
    fileprivate func inputFields() -> some View {
        return Group {
            TextField(Constants.email, text: $email)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
            
            SecureField(Constants.password, text: $password)
            
        }.padding(12)
            .background(Color.white)
    }
}
