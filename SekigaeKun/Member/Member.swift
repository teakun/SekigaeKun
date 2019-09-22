//
//  Member.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import Foundation

class Member: Codable, Equatable {
    let id: String
    let name: String
    var attend: Bool
    var task: Bool
    var solo: Bool

    init(name: String) {
        self.id = Member.generateID()
        self.name = name
        self.attend = true
        self.task = false
        self.solo = false
    }
    
    static func ==(lhs: Member, rhs: Member) -> Bool{
        return lhs.id == rhs.id
    }
    
    static func generateID() -> String {
        let length = 16
        let seed = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        
        var result = ""
        for _ in 0..<length {
            result += "\(seed.randomElement()!)"
        }
        print(result)
        return result
    }
}


