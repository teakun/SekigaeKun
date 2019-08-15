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
    var ios: Bool
    var bff: Bool
    var attend: Bool

    init(name: String) {
        self.name = name
        self.ios = true
        self.bff = true
        self.attend = true
    }
}
