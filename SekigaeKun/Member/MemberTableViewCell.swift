import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapNameLabel))
            nameLabel.addGestureRecognizer(tapGesture)
        }
    }
    
    @IBOutlet weak var attendButton: UIButton! {
        didSet {
            attendButton.layer.cornerRadius = 4
            attendButton.clipsToBounds = true
            attendButton.setTitleColor(.white, for: .normal)
            attendButton.backgroundColor = .carrot
        }
    }

    @IBOutlet weak var taskButton: UIButton! {
        didSet {
            taskButton.layer.cornerRadius = 4
            taskButton.clipsToBounds = true
            taskButton.backgroundColor = .amethyst
            taskButton.setTitleColor(.white, for: .normal)
        }
    }
    
    @IBOutlet weak var soloButton: UIButton! {
        didSet {
            soloButton.layer.cornerRadius = 4
            soloButton.clipsToBounds = true
            soloButton.backgroundColor = .greenSea
            soloButton.setTitleColor(.white, for: .normal)
        }
    }
    
    
    private var member: Member?
    private var editHandler: ((Member) -> Void)?
    
    func set(member: Member, editHandler: ((Member) -> Void)?) {
        self.member = member
        self.editHandler = editHandler
        update()
    }
    
    func update() {
        guard let member = member else { return }
        nameLabel.text = member.name
        if member.attend {
            attendButton.backgroundColor = .carrot
        } else {
            attendButton.backgroundColor = .lightGray
        }
        
        if member.task {
            taskButton.backgroundColor = .amethyst
        } else {
            taskButton.backgroundColor = .lightGray
        }
        
        if member.solo {
            soloButton.backgroundColor = .greenSea
        } else {
            soloButton.backgroundColor = .lightGray
        }
    }
    
    
    @IBAction func didTapAttendButton(_ sender: UIButton) {
        member?.attend.toggle()
        update()
    }
    
    @IBAction func didTapTaskButton(_ sender: UIButton) {
        member?.task.toggle()
        update()
    }
    
    @IBAction func didTapSoloButton(_ sender: UIButton) {
        member?.solo.toggle()
        update()
    }
    
    @objc func didTapNameLabel() {
        if let member = member {
            editHandler?(member)
        }
    }
    
}
