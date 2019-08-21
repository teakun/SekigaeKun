//
//  SekigaeViewController.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit
import AVFoundation

class SekigaeViewController: UIViewController {

    private var manager = MemberManager.sharedInstance
    private var seatViews: [SeatView] = []
    private var memberViews: [MemberView] = []

    private let memberViewWidth: CGFloat = 50
    private let seatNameHeight: CGFloat = 20
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        let memberButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SekigaeViewController.didTapMemberButton))
        navigationItem.rightBarButtonItem = memberButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareSeatView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func prepareSeatView() {
        
        memberViews.forEach{ $0.removeFromSuperview() }
        memberViews = []
        

        if manager.attendMember.count == seatViews.count {
            return
        }
        
        seatViews.forEach {
            $0.removeFromSuperview()
        }
        seatViews.removeAll()

        for i in seatViews.count..<manager.attendMember.count {
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
        playDrumroll()
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.5) {
            self.sekigae()
        }
    }
    
    private func sekigae() {
        let members = manager.attendMember
        
        members.forEach{
            let memberView = MemberView.instantiate()
            memberView.frame = CGRect(origin: CGPoint(x: (self.view.frame.width - memberViewWidth) / 2, y:  (self.view.frame.height - memberViewWidth) / 2), size: CGSize(width: memberViewWidth, height: memberViewWidth))
            memberView.member = $0
            self.view.addSubview(memberView)
            memberViews.append(memberView)
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

extension SekigaeViewController: AVAudioPlayerDelegate {
    func playDrumroll() {
        guard let path = Bundle.main.path(forResource: "drumroll", ofType: "mp3") else {
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer.delegate = self
            audioPlayer.volume = 1.0
            audioPlayer.play()
        } catch {
        }
    }
}

