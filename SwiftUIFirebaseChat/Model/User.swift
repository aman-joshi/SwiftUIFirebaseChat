//
//  User.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 15/05/22.
//

import Foundation

struct User:Codable,Identifiable {
    var email:String = ""
    var profileImageUrl:String = ""
    var id:String = ""
}
