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

    var member: Member? {
        didSet {
            self.nameLabel.text = member!.name
        }
    }

}
