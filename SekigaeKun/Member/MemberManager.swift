//
//  MemberManager.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/17.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import Foundation

class MemberManager: NSObject {
    private let memberKey = "SekigaeKun-member"
    
    static let sharedInstance = MemberManager()
    var members: [Member] = []
    
    var attendMember: [Member] {
        return members.filter{ $0.attend == true }
    }
    
    override init() {
        super.init()
        load()
    }
    
    func addMember(name: String) {
        let member = Member(name: name)
        members.append(member)
    }
    
    func removeMember(index: Int) {
        members.remove(at: index)
    }
    
    func save() {
        do {
            let encodedData = try JSONEncoder().encode(members)
            UserDefaults.standard.set(encodedData, forKey: memberKey)
        } catch let error {
            print(error)
            return
        }
    }
    
    func load() {
        guard let data = UserDefaults.standard.data(forKey: memberKey) else { return }
        
        do {
            let decoded = try JSONDecoder().decode([Member].self, from: data)
            self.members = decoded
        } catch let error {
            print(error)
            return
        }
    }

}
