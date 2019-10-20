//
//  SeatView.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/17.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit

protocol SeatViewDelegate: class {
    func didMove(seatView view: SeatView)
}

class SeatView: UIView {

    @IBOutlet weak var seatLabel: UILabel!
    
    @IBOutlet weak var firstMemberView: UIView!
    @IBOutlet weak var secondMemberView: UIView!
    
    
    weak var delegate: SeatViewDelegate?
    
    override func draw(_ rect: CGRect) {
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    
    var seat: Seat?
    func set(seat: Seat) {
        self.seat = seat
        seatLabel.text = seat.type.rawValue
    }
    
    func returnTargetView(from member: Member) -> UIView? {
        if member === seat?.member1 {
            return firstMemberView
        } else if member === seat?.member2 {
            return secondMemberView
        } else {
            return nil
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }

        let before = touch.previousLocation(in: superview)
        let after = touch.location(in: superview)

        var frame : CGRect = self.frame
        let dx = (after.x - before.x)
        let dy = (after.y - before.y)
        frame.origin.x += dx
        frame.origin.y += dy
        self.frame = frame
        delegate?.didMove(seatView: self)
    }

}
