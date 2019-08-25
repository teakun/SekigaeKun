import Foundation

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
    
    static func sekigae(members: [Member], seats: [Seat]) {
        seats.forEach { $0.reset() }
        
        let attendMembers = members.filter{ $0.attend == true }
        let soloMembers = attendMembers.filter{ $0.solo == true }
        var taskMembers = attendMembers.filter{ ($0.solo == false) && ($0.task == true) }
        let normalMembers = attendMembers.filter{ ($0.solo == false) && ($0.task == false) }
        // ソロから埋める
        
        var soloSeats = seats.filter{ $0.type == .solo }
        soloSeats.shuffle()
        
        for (index, member) in soloMembers.shuffled().enumerated() {
            soloSeats[index / 2].setMember(member: member)
        }
        
        // ソロのあまりの席
        let amariSoloSeat = (soloSeats.last?.hasAmari ?? false) ? soloSeats.last : nil
        
        // ペアを埋める
        let pairSeats = seats.filter{ $0.type == .pair }
        
        taskMembers.shuffle()
        
        var setTaskMemberIndex: Int? = nil
        
        for (index, seat) in pairSeats.enumerated() {
            if let member = taskMembers[safe: index] {
                seat.setMember(member: member)
                setTaskMemberIndex = index
            }
        }
        // タスクがあるのにまだ席が決まっていないメンバのインデックス
        setTaskMemberIndex? += 1
        // 座席の決まったタスクありメンバーがタスクありメンバーの合計より少ない場合
        var amariTaskMember: [Member] = []
        
        if let index = setTaskMemberIndex {
            if index < taskMembers.count {
                amariTaskMember = taskMembers[index..<taskMembers.count].map{ $0 }
            }
        }
        
        // 残ったメンバを残った席につめる
        var amariMember = normalMembers + amariTaskMember
        amariMember.shuffle()
        
        var lastMember: Member? = nil
        var seatIndex: Int = 0
        for member in amariMember {
            var continueAssign: Bool = true

            if pairSeats.count == 0 { break }
            repeat {
                if pairSeats[seatIndex].setMember(member: member) {
                    continueAssign = false
                } else {
                    seatIndex += 1
                    if seatIndex == pairSeats.count {
                        continueAssign = false
                        lastMember = member
                    }
                }

            } while continueAssign
            
        }
        
        if let last = lastMember {
            amariSoloSeat?.setMember(member: last)
        }
        print(seats)
    }

}
