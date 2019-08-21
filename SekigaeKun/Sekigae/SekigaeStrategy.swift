//
//  SekigaeStrategy.swift
//  SekigaeKun
//
//  Created by 武田悠暉 on 2019/08/22.
//  Copyright © 2019 TAKEDA Yuki. All rights reserved.
//

import Foundation

enum SeatType: String {
    case pair = "ペア"
    case solo = "ソロ"
}

class Seat {
    let type: SeatType

    var member1: Member? = nil
    var member2: Member? = nil

    init(type: SeatType) {
        self.type = type
    }
}

class SekigaeStrategy {
    static func prepareSeat(members: [Member]) -> [Seat] {
        let attendMember = members.filter { $0.attend == true }
        
        let pairMemberCount = attendMember.filter { $0.solo == false }.count
        let pairSeatCount: Int = pairMemberCount / 2
        let hasPairAmari = pairMemberCount % 2 == 1
    
        let soloMemberCount = attendMember.filter { $0.solo == true }.count
        var soloSeatCount: Int = soloMemberCount / 2
        let hasSoloAmari = soloMemberCount % 2 == 1
        
        if hasPairAmari || hasSoloAmari {
            soloSeatCount += 1
        }
        
        var seats: [Seat] = []
        
        (0..<pairSeatCount).forEach { _ in seats.append(Seat(type: .pair)) }
        (0..<soloSeatCount).forEach { _ in seats.append(Seat(type: .solo)) }
        
        return seats
    }
}
