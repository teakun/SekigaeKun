//
//  SekigaeViewController.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit

class SekigaeViewController: UIViewController {

    private var manager = MemberManager.sharedInstance
    private var seatViews: [SeatView] = []
    private var memberViews: [MemberView] = []

    private let memberViewWidth: CGFloat = 50
    private let seatNameHeight: CGFloat = 20
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        let memberButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SekigaeViewController.didTapMemberButton))
        navigationItem.rightBarButtonItem = memberButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        prepareSeatView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func prepareSeatView() {
        seatViews.filter{ $0.number! > self.manager.members.count}
                 .forEach{
            $0.removeFromSuperview()
            seatViews.remove(at: $0.number!)
        }

        for i in seatViews.count..<manager.members.count {
            let seat = SeatView.instantiate()
            seat.number = i
            seat.frame = CGRect(x: CGFloat(i*10), y: CGFloat(i*10), width: memberViewWidth, height: memberViewWidth+CGFloat(20))
            view.addSubview(seat)
            seatViews.append(seat)
        }
    }

    @objc func didTapMemberButton() {
        present(UINavigationController(rootViewController: MemberTableViewController()), animated: true, completion: nil)
    }

    @IBAction func didTouchUpInsideSekigaeButton(_ sender: UIButton) {

        let members = manager.members

        if memberViews.count != seatViews.count {
            memberViews.forEach{ $0.removeFromSuperview() }
            memberViews = []

            members.forEach{
                let memberView = MemberView.instantiate()
                memberView.frame = CGRect(origin: CGPoint(x: (self.view.frame.width - memberViewWidth) / 2, y:  (self.view.frame.height - memberViewWidth) / 2), size: CGSize(width: memberViewWidth, height: memberViewWidth))
                memberView.member = $0
                self.view.addSubview(memberView)
                memberViews.append(memberView)
            }
        }

        memberViews.shuffle()
        
        for (i, view) in memberViews.enumerated() {
            UIView.animate(withDuration: 0.3, animations: {
                view.center = self.seatViews[i].memberView.center
                view.frame.origin.x = self.seatViews[i].frame.origin.x
                view.frame.origin.y = self.seatViews[i].frame.origin.y + self.seatNameHeight
            })
        }


    }









































}
