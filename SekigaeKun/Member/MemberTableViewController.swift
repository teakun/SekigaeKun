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

        let addButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(MemberTableViewController.didPushAddMemberButton))
        let dismissButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(MemberTableViewController.didTapDismissButton))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = dismissButton
        
        self.tableView.register(cellType: MemberTableViewCell.self)
        tableView.rowHeight = 50
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func didTapDismissButton() {
        manager.save()
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
        let cell = self.tableView.dequeueReusableCell(with: MemberTableViewCell.self, for: indexPath)
        cell.set(member: manager.members[indexPath.row])
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        manager.removeMember(index: indexPath.row)
        tableView.reloadData()
    }
}
