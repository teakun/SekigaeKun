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
    func viewDidLoad()
    func didTapNameEditButton()
    func didTapIconEditButton()
    func edited(name: String)
    func didFinishPicking(image: UIImage?)
}

protocol MemberEditPresenterOutput {
    func updateUI(viewData: MemberEditViewData)
    func showImagePicker()
    func showNameEditAlert()
}

struct MemberEditViewData {
    let name: String
    let iconImage: UIImage?
}

class MemberEditPresenterImpl: MemberEditPresenter {
    
    var output: MemberEditPresenterOutput?
    
    private var member: Member
    private var viewData: MemberEditViewData {
        get {
            return MemberEditViewData(name: member.name, iconImage: member.icon)
        }
    }
    
    init(member: Member) {
        self.member = member
    }
    
    func viewDidLoad() {
        output?.updateUI(viewData: viewData)
    }
    
    func didTapNameEditButton() {
        output?.showNameEditAlert()
    }
    
    func didTapIconEditButton() {
        output?.showImagePicker()
    }

    func didFinishPicking(image: UIImage?) {
        self.member.icon = image
        MemberManager.sharedInstance.save()
        output?.updateUI(viewData: viewData)
    }

    func edited(name: String) {
        self.member.name = name
        MemberManager.sharedInstance.save()
        output?.updateUI(viewData: viewData)
        
    }
}
