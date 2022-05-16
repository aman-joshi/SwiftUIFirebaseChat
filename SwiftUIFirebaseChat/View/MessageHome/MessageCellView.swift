//
//  MessageCellView.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 13/05/22.
//

import SwiftUI

struct MessageCellView: View {
    var body: some View {
        VStack {
            HStack(spacing:16) {
                Image(systemName: "person.fill")
                    .font(.system(size: 32))
                    .padding(8)
                    .addOverlay(radius: 44)
                VStack(alignment:.leading) {
                    Text("Username")
                        .font(.system(size: AppFont.FontSize.medium,weight: .bold))
                    Text("Message sent to user")
                        .font(.system(size: AppFont.FontSize.small))
                        .foregroundColor(AppColor.lightGray)
                }
                Spacer()
                Text("22d").font(.system(size: AppFont.FontSize.small,weight: .semibold))
            }
            Divider()
                .padding(.vertical,8)
        }.padding(.horizontal)
    }
}

struct MessageCellView_Previews: PreviewProvider {
    static var previews: some View {
        MessageCellView()
    }
}
