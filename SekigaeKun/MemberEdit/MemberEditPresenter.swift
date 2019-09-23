//
//  MemberEditPresenter.swift
//  SekigaeKun
//
//  Created by teakun on 2019/09/23.
//  Copyright © 2019 TAKEDA Yuki. All rights reserved.
//

import Foundation
import UIKit

protocol MemberEditPresenter {
}

protocol MemberEditPresenterOutput {
    func updateUI(viewData: MemberEditViewData)
}

struct MemberEditViewData {
    let name: String
    let iconImage: UIImage?
}

class MemberEditPresenterImpl: MemberEditPresenter {
    var output: MemberEditPresenterOutput?
    
    private let member: Member
    
    init(member: Member) {
        self.member = member
    }

}
