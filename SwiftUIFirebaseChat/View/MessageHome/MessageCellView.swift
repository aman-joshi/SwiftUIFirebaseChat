//
//  MessageCellView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 13/05/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MessageCellView: View {
    
    var user:User
    var showUsersOnly = true
    
    var body: some View {
        VStack {
            HStack(spacing:16) {
                WebImage(url: URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipped()
                    .cornerRadius(50)
                    .addOverlay(radius: 50)
                VStack(alignment:.leading) {
                    Text(user.email)
                        .font(.system(size: AppFont.FontSize.medium,weight: .bold))
                    if !showUsersOnly {
                        Text("Message sent to user")
                            .font(.system(size: AppFont.FontSize.small))
                            .foregroundColor(AppColor.lightGray)
                    }
                }
                Spacer()
                if !showUsersOnly {
                    Text("22d").font(.system(size: AppFont.FontSize.small,weight: .semibold))
                }
            }
            Divider()
                .padding(.vertical,8)
        }.padding(.horizontal)
    }
}
