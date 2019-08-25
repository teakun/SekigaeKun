//
//  MemberView.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/18.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit

class MemberView: UIView {

    @IBOutlet weak var nameLabel: UILabel!

    var member: Member?
    var handler: ((Member) -> Void)?
    
    func set(member: Member, handler: @escaping ((Member) -> Void)) {
        self.member = member
        self.handler = handler
        self.nameLabel.text = member.name
    }

    @IBAction func didTapButton(_ sender: UIButton) {
        select()
        if let member = member {
             handler?(member)
        }
    }
    
    func select() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 4
    }
    
    func deselect() {
        layer.borderColor = UIColor.red.cgColor
        layer.borderWidth = 0
    }
    
}
