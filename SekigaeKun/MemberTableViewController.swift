//
//  MemberTableViewController.swift
//  SekigaeKun
//
//  Created by Yuki Takeda on 2018/07/16.
//  Copyright © 2018年 TAKEDA Yuki. All rights reserved.
//

import UIKit

class MemberTableViewController: UITableViewController {

    private let manager = MemberManager.sharedInstance
    private let identifer = "identifer"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MemberTableViewController.didPushAddMemberButton))
        let dismissButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MemberTableViewController.didTapDismissButton))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = dismissButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func didTapDismissButton() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc func didPushAddMemberButton(){
        let alert = UIAlertController(title: "新規メンバ", message: "名前を入力してください", preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default, handler: { (action:UIAlertAction!) -> Void in
            guard let textFields = alert.textFields else { return }
            var name = ""
            for field in textFields {
                if let text = field.text {
                    name += text
                }
            }
            self.saveNewMember(name: name)
        })
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel, handler: nil)

        alert.addTextField(configurationHandler: { (field: UITextField!) -> Void in
            field.placeholder = "なまえ"
        })

        alert.addAction(ok)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)
    }

    func saveNewMember(name: String) {
        manager.addMember(name: name)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.members.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: identifer) ?? UITableViewCell()
        cell.textLabel?.text = manager.members[indexPath.row].name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
