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
        presenter.viewDidLoad()
    }
    
    @IBAction func didTapNameEditButton(_ sender: UIButton) {
        presenter.didTapNameEditButton()
    }
    
    @IBAction func didTapIconEditButton(_ sender: UIButton) {
        presenter.didTapIconEditButton()

    }
}

extension MemberEditViewController: MemberEditPresenterOutput {
    func showImagePicker() {
        let picker: UIImagePickerController = UIImagePickerController()
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func showNameEditAlert() {
        let alert = UIAlertController(title: "編集", message: "新しい名前を入力してください", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: { [weak self] (action:UIAlertAction!) -> Void in
            guard let textFields = alert.textFields else { return }
            var name = ""
            for field in textFields {
                if let text = field.text {
                    name += text
                }
            }
            self?.presenter.edited(name: name)
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)

        alert.addTextField(configurationHandler: { (field: UITextField!) -> Void in
            field.placeholder = "なまえ"
        })

        alert.addAction(ok)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func updateUI(viewData: MemberEditViewData) {
        nameLabel.text = viewData.name
        iconImageView.image = viewData.iconImage
    }
}

extension MemberEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        presenter.didFinishPicking(image: image)
        self.dismiss(animated: true, completion: nil)
    }
}
