//
//  SeatView.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/17.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit

class SeatView: UIView {

    @IBOutlet weak var seatLabel: UILabel!
    @IBOutlet weak var memberView: UIView!

    var number: Int? {
        didSet {
            seatLabel.text = String(number!)
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
    }

}
