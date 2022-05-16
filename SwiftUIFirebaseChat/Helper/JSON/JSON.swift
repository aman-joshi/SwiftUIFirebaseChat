//
//  JSON.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 15/05/22.
//

import Foundation

extension Data {
    func toJSON() throws -> JSON? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: .fragmentsAllowed) as? JSON
            return json
        }catch {
            throw error
        }
    }
}


extension Dictionary {
    
    func toData() throws -> Data {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
            return data
        }catch {
            throw error
        }
    }
}
