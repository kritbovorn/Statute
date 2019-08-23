//
//  ContactTableViewController.swift
//  Statute
//
//  Created by Kritbovorn on 22/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

class ContactTableViewController: UITableViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        profileImageView.layer.cornerRadius = 16
        profileImageView.layer.masksToBounds = true
    }

    // MARK: - Table view data source


    

}
