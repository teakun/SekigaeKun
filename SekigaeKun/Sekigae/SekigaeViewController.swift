//
//  SekigaeViewController.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit
import AVFoundation

class SekigaeViewControllerFactory {
    static func create() -> SekigaeViewController {
        let presenter = SekigaePresenterImpl()
        let vc = SekigaeViewController(presenter: presenter)
        presenter.output = vc
        return vc
    }
}

class SekigaeViewController: UIViewController {

    private let presenter: SekigaePresenter
    private var seatViews: [SeatView] = []
    private var memberViews: [MemberView] = []

    let col: Int = 2
    
    var audioPlayer: AVAudioPlayer!
    
    init(presenter: SekigaePresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: SekigaeViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isTranslucent = false
        let memberButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(SekigaeViewController.didTapMemberButton))
        navigationItem.rightBarButtonItem = memberButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.viewDidAppear()
    }

    @objc func didTapMemberButton() {
        presenter.didTapMemberButton()
    }

    @IBAction func didTouchUpInsideSekigaeButton(_ sender: UIButton) {
        presenter.didTouchUpInsideSekigaeButton()
    }
        
    private func moveMemberViewToTargetPosition() {
        for memberView in memberViews {
            var targetView: UIView?
            guard let member = memberView.member else { return }
            
            for seat in seatViews {
                if let view = seat.returnTargetView(from: member) {
                    targetView = view
                }
            }
            
            guard let target = targetView else { return }
            
            let targetFrame = target.convert(target.bounds, to: self.view)
            
            UIView.animate(withDuration: 0.3) {
                memberView.frame = targetFrame
            }
        }
    }
        
    private func calcSeatFrame(index: Int) -> CGRect {

        let column = CGFloat(col)
        
        let seatWidth = UIScreen.main.bounds.width / (column + 1)
        let seatHeight = UIScreen.main.bounds.width / (column + 1)
        
        let margin = (UIScreen.main.bounds.width - (seatWidth * column)) / (column + 1)
        
        let targetColumn = index % col
        let targetRow = index / col
        
        let targetX = (margin * CGFloat(targetColumn + 1)) + (seatWidth * CGFloat(targetColumn))
        let targetY = (margin * CGFloat(targetRow + 1)) + (seatHeight * CGFloat(targetRow))
        
        return CGRect(x: targetX, y: targetY, width: seatWidth, height: seatHeight)
    }
    
    private func calcMemberSize() -> CGSize {
        let column = CGFloat(col)
        let seatWidth = UIScreen.main.bounds.width / (column + 1)
        let seatHeight = seatWidth * 0.3

        return CGSize(width: seatWidth, height: seatHeight)
    }
    
}

extension SekigaeViewController: SekigaeOutput {
    func presentMemberTableView() {
        let vc = UINavigationController(rootViewController: MemberTableViewController())
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    func prepareSeatView(seats: [Seat]) {
        seatViews.forEach { $0.removeFromSuperview() }
        seatViews = []
        
        memberViews.forEach { $0.removeFromSuperview() }
        memberViews = []
        
        for (index, seat) in seats.enumerated() {
            let seatView = SeatView.instantiate()
            seatView.delegate = self
            seatView.set(seat: seat)
            seatView.frame = calcSeatFrame(index: index)
            seatViews.append(seatView)
            view.addSubview(seatView)
        }
    }
    
    func prepareMemberView(members: [Member]) {
        members.forEach{
            let memberView = MemberView.instantiate()
            memberView.frame = CGRect(origin: CGPoint(x: self.view.frame.width / 2,
                                                      y:  self.view.frame.height / 2),
                                      size: calcMemberSize())
            memberView.set(member: $0) { [weak self] member in
                self?.presenter.select(member: member)
            }
            self.view.addSubview(memberView)
            memberViews.append(memberView)
        }

    }
    
    func doSekigae(seats: [Seat]) {
        playDrumroll()
        moveMemberViewToTargetPosition()
    }
    
    func swap() {
        moveMemberViewToTargetPosition()
        memberViews.forEach{ $0.deselect() }
    }

}

extension SekigaeViewController: SeatViewDelegate {
    func didMove(seatView view: SeatView) {
        for memberView in memberViews {
            var targetView: UIView?
            guard let member = memberView.member else { return }
            
            for seat in seatViews {
                if let view = seat.returnTargetView(from: member) {
                    targetView = view
                }
            }
            
            guard let target = targetView else { return }
            
            let targetFrame = target.convert(target.bounds, to: self.view)
            
            memberView.frame = targetFrame
        }
    }
}


extension SekigaeViewController: AVAudioPlayerDelegate {
    func playDrumroll() {
        guard let path = Bundle.main.path(forResource: "sound", ofType: "mp3") else {
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

