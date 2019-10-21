//
//  SekigaePresenter.swift
//  SekigaeKun
//
//  Created by teakun on 2019/10/21.
//  Copyright © 2019 TAKEDA Yuki. All rights reserved.
//

import Foundation

protocol SekigaePresenter: class {
    func viewDidAppear()
    func didTapMemberButton()
    func didTouchUpInsideSekigaeButton()
    func select(member: Member)
}

protocol SekigaeOutput: class {
    func prepareSeatView(seats: [Seat])
    func presentMemberTableView()
    func prepareMemberView(members: [Member])
    func doSekigae(seats: [Seat])
    func swap()
}

class SekigaePresenterImpl: SekigaePresenter {
    var output: SekigaeOutput?
    private let manager = MemberManager.sharedInstance
    private var seats: [Seat] = []
    
    private var selectedMember: Member?
    private var didSekigae: Bool = false

    init() {
    }
    
    
    func viewDidAppear() {
        didSekigae = false
        self.seats = SekigaeStrategy.prepareSeat(members: MemberManager.sharedInstance.attendMember)
        output?.prepareSeatView(seats: seats)
    }
    
    func didTapMemberButton() {
        output?.presentMemberTableView()
    }
    
    func didTouchUpInsideSekigaeButton() {
        let member = manager.attendMember
        SekigaeStrategy.sekigae(members: member, seats: seats)

        if !didSekigae {
            output?.prepareMemberView(members: member)
            didSekigae = true
        }
        
        output?.doSekigae(seats: seats)
    }
    
    func select(member: Member) {
        if let selected = selectedMember {
            seats.forEach {
                $0.swap(target: selected, new: member)
            }
            selectedMember = nil
            output?.swap()
        } else {
            selectedMember = member
        }
    }
    
    
}


