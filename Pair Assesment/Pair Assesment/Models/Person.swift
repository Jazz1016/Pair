//
//  File.swift
//  Pair Assesment
//
//  Created by James Lea on 5/21/21.
//

import Foundation

class Person: Codable {
    
    let name: String
    let uuid: String
    
    init(name: String, uuid: String = UUID().uuidString){
        
        self.name = name
        self.uuid = uuid
        
    }
    
}

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool{
        return lhs.uuid == rhs.uuid
    }
}
