import Foundation

enum SeatType: String {
    case pair = "ペア"
    case solo = "ソロ"
}

class Seat {
    let type: SeatType
    var member1: Member? = nil
    var member2: Member? = nil
    
    var hasAmari: Bool {
        return (member1 == nil) || (member2 == nil)
    }
    
    var emptySeatCount: Int {
        var count = 2
        if member1 == nil { count -= 1 }
        if member2 == nil { count -= 1 }
        return count
    }
    
    init(type: SeatType) {
        self.type = type
    }
    
    @discardableResult func setMember(member: Member) -> Bool {
        if member1 == nil {
            member1 = member
            return true
        } else if member2 == nil {
            member2 = member
            return true
        } else {
            return false
        }
    }
    
    func reset() {
        member1 = nil
        member2 = nil
    }
}

