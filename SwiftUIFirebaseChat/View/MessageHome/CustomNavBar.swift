//
//  CustomNavBar.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 13/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomNavBar:View {
    
    @Binding var showLogoutOption:Bool
    @Binding var username:String
    @Binding var profileImageUrl:String
    
    var body:some View {
        VStack {
            HStack(spacing:16) {
                WebImage(url: URL(string: profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(50)
                    .addOverlay(radius: 50)
                    .shadow(radius: 5)
                VStack(alignment:.leading,spacing: 4) {
                    Text(username)
                        .font(.system(size: AppFont.FontSize.medium,weight: .bold))
                    HStack {
                        Circle()
                            .foregroundColor(AppColor.green)
                            .frame(width: 14, height: 14)
                        Text("Online")
                            .font(.system(size: AppFont.FontSize.small))
                            .foregroundColor(AppColor.lightGray)
                    }
                }
                Spacer()
                Button {
                    showLogoutOption.toggle()
                } label: {
                    Image(systemName: "gear")
                        .font(.system(size: 32,weight: .heavy))
                }
            }
        }
        .padding()
    }
}
