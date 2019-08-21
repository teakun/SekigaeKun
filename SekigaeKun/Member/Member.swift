//
//  Member.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import Foundation

class Member: Codable {
    let name: String
    var attend: Bool
    var task: Bool
    var solo: Bool

    init(name: String) {
        self.name = name
        self.attend = true
        self.task = false
        self.solo = false
    }
}
