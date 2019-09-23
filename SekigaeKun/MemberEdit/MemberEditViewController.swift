//
//  MemberEditViewController.swift
//  SekigaeKun
//
//  Created by teakun on 2019/09/23.
//  Copyright © 2019 TAKEDA Yuki. All rights reserved.
//

import UIKit

class MemberEditViewControllerFactory {
    static func create(member: Member) -> MemberEditViewController {
        let presenter = MemberEditPresenterImpl(member: member)
        let vc = MemberEditViewController(presenter: presenter)
        presenter.output = vc
        return vc
    }
}

class MemberEditViewController: UIViewController {
    private let presenter: MemberEditPresenter
    
    init(presenter: MemberEditPresenter) {
        self.presenter = presenter
        super.init(nibName: String(describing: MemberEditViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.layer.cornerRadius = 4
            iconImageView.clipsToBounds = true
        }
    }

    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MemberEditViewController: MemberEditPresenterOutput {
    func updateUI(viewData: MemberEditViewData) {
        nameLabel.text = viewData.name
    }
}
