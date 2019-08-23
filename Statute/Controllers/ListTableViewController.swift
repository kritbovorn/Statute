//
//  ListTableViewController.swift
//  Statute
//
//  Created by Kritbovorn on 10/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var pdfArray = [String]()
    
    var fileString = ""
    
    lazy var refresher: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .blue
        refreshControl.addTarget(self, action: #selector(refreshTable), for: .valueChanged)
        
        return refreshControl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ที่บันทึกไว้"

        setupFileManager()
        
//        if #available(iOS 10.0, *) {
//            tableView.refreshControl = refresher
//        }else{
//            tableView.addSubview(refresher)
//        }
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.tableFooterView = UIView()
        
        pdfArray = [String]()
        
        setupFileManager()
        
        tableView.reloadData()
    }
    
    
    
    func setupFileManager() {
        
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileDocuments = try FileManager.default.contentsOfDirectory(at: fileManager, includingPropertiesForKeys: nil, options: [])
            let fileDoc = fileDocuments.filter {$0.pathExtension == "pdf"}
            
            for fileDocument in fileDoc {
                let fileString = fileDocument.lastPathComponent
                
                pdfArray.append(fileString)
            }
        }catch let err {
            print(err.localizedDescription)
        }
    }
    
    @objc func refreshTable() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            
            self.tableView.reloadData()
            
            self.refresher.endRefreshing()

        }

    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pdfArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = pdfArray[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        //cell.imageView?.image = UIImage(named: "719220")
        
        return cell
    }
    
    // FIXME: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "ยังไม่ได้ มีการ Save พรบ เข้ามาในระบบ."
        label.textAlignment = .center
        label.textColor = UIColor.red
        
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return pdfArray.count > 0 ? 0 : 280
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPDF" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as? LocalPDFViewController
                destination?.pdfString = pdfArray[indexPath.row]
            }
        }
    }
    
}
