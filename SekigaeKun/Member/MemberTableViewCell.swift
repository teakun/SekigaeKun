import UIKit

class MemberTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attendSwitch: UISwitch!
    
    private var member: Member?
    
    func set(member: Member) {
        self.member = member
        
        nameLabel.text = member.name
        attendSwitch.isOn = member.attend
    }
    
    @IBAction func attendSwitchValueChanged(_ sender: UISwitch) {
        member?.attend = sender.isOn
    }
}
