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

    let member: Member

    init(frame: CGRect, member: Member) {
        self.member = member
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
