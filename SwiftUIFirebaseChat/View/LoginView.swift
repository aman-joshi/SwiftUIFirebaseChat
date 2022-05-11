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
    
    @ObservedObject var viewModel:LoginViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    pickerView()
                    if !isLoginMode {
                        Button {
                            //
                        } label: {
                            Image(systemName: "person.fill")
                                .font(.system(size: 64))
                                .padding()
                        }
                    }
                    inputFields()
                    Button {
                        if isLoginMode {
                            viewModel.logInUser(withEmail: email, password: password)
                        }else {
                            viewModel.createNewAccount(withEmail: email, password: password)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text( isLoginMode ? Constants.login : Constants.createAccount)
                                .foregroundColor(.white)
                                .padding(.vertical,10)
                                .font(.system(size: 14, weight: .semibold))
                            Spacer()
                        }.background(Color.blue)
                    }
                    Text(viewModel.loginStatusMessage).foregroundColor(Color.red)
                        .frame(maxWidth:.infinity,alignment: .leading)
                       
                }.padding()
            }
            .navigationTitle( isLoginMode ? Constants.login : Constants.createAccount)
            .background(Color(.init(white: 0, alpha: 0.05)))
        }
        .navigationViewStyle(StackNavigationViewStyle())
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel())
    }
}
