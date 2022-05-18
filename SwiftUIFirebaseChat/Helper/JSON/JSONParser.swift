//
//  JSONParser.swift
//  SwiftUIFirebaseChat
//
//  Created by Aman Joshi on 18/05/22.
//

import Foundation

struct JSONParser<T:Codable> {
    
    func parseToModel(from json:JSON) throws -> T {
        do {
            let data = try json.toData()
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        }catch {
            throw error
        }
    }
}
