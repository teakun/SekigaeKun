//
//  Member.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import Foundation
import UIKit

class Member: Codable, Equatable {
    let id: String
    var name: String
    var attend: Bool
    var task: Bool
    var solo: Bool
    var icon: UIImage?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case attend
        case task
        case solo
        case icon
    }

    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self , forKey: .id)
        name = try values.decode(String.self , forKey: .name)
        attend = try values.decode(Bool.self, forKey: .attend)
        task = try values.decode(Bool.self, forKey: .task)
        solo = try values.decode(Bool.self , forKey: .solo)

        if let imageDataBase64String = try? values.decode(String.self, forKey: .icon) {
            if let data = Data(base64Encoded: imageDataBase64String) {
                icon = UIImage(data: data)
            } else {
                icon = nil
            }
        } else {
            icon = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(attend, forKey: .attend)
        try container.encode(task, forKey: .task)
        try container.encode(solo, forKey: .solo)

        if let icon = icon, let imageData = icon.pngData() {
            let imageDataBase64String = imageData.base64EncodedString()
            try container.encode(imageDataBase64String, forKey: .icon)
        }
    }
    
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


