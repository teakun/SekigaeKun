//
//  MemberManager.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/17.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import Foundation

class MemberManager: NSObject {
    static let sharedInstance = MemberManager()
    var members: [Member] = []

    func addMember(name: String) {
        let member = Member(name: name)
        members.append(member)
    }

}
