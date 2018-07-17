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
            seat.frame = CGRect(x: i*10, y: i*10, width: 50, height: 70)
            view.addSubview(seat)
            seatViews.append(seat)
        }
    }

    @objc func didTapMemberButton() {
        present(UINavigationController(rootViewController: MemberTableViewController()), animated: true, completion: nil)
    }




}
