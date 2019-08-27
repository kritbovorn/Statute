//
//  StatTableViewController.swift
//  Statute
//
//  Created by Kritbovorn on 9/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//  https://medium.com/@nimjea/json-parsing-in-swift-2498099b78f
//

import UIKit

class StatuteTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    let cellID = "StatuteCell"
    let jsonString = "https://tyre.in.th/Statute/JsonStat.php"
    
    var statutes = [Statute]()
    var filteredStatutes = [Statute]()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 40/255, green: 42/255, blue: 54/255, alpha: 1.0)
        
        tableView.tableFooterView = UIView()
        
        title = "พระราชบัญญัติ"
        
        searchBarSetup()
        
        APIService.shared.decodableJsonFromURL(jsonString: jsonString) { (statutes, isError) in
            
            // Show Message when have Error()
            self.setMessageURLError(isError: isError)
            
            guard let statutes = statutes else { return }
            self.statutes = statutes
            self.tableView.reloadData()
        }
    }
    
    // FIXME: - Setup Search Bar
    private func searchBarSetup() {
        
        searchController.searchBar.delegate = self
        //searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "ค้นหา ..."
        //searchController.dimsBackgroundDuringPresentation = false
        //searchController.searchBar.barTintColor = UIColor.red
        searchController.searchBar.barStyle = .blackOpaque
        searchController.searchBar.barTintColor = UIColor.yellow
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
    }
    
    func decodeJsonData() {
        
        //let jsonString = "https://tyre.in.th/Statute/JsonStatute.php"
        let jsonString = "https://tyre.in.th/Statute/JsonStat.php"
        guard let url = URL(string: jsonString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                if let error = err {
                    print("error\(error.localizedDescription)")
                }
                guard let data = data else { return }
                
                do {
                    
                    self.statutes = try JSONDecoder().decode([Statute].self, from: data)
                    self.tableView.reloadData()
                   
                }catch let jsonErr {
                    print("mistake\(jsonErr.localizedDescription)")
                }
            }
            
        }.resume()
        
    }
    
    // FIXME: -  Show Alert Message when have error from URLSession()
    
    fileprivate func setMessageURLError(isError: URLError?) {
        
        if isError != nil {
            
            let isErr = isError?.code.rawValue
            if isErr == NSURLErrorNotConnectedToInternet {
                
                self.alertError(title: "Oops!!!", message: "รบกวนตรวจสอบ การเชื่อมต่ออินเตอร์เน็ต \nกรุณาลองใหม่อีกครั้ง นะครับ.")
                
            }else if isErr == NSURLErrorBadServerResponse {
                self.alertError(title: "Oops!!!", message: "เกิดข้อผิดพลาดในการเชื่อมต่อ Server.")
                
            }else{
                self.alertError(title: "Oops!!!", message: "เกิดปัญหาข้อผิดพลาด กรุณาลองใหม่อีกครั้ง นะครับ.")
                
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return statutes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! StatuteTableViewCell
        
        let statute = statutes[indexPath.row]
        cell.statute = statute
        
        
        cell.backgroundColor = UIColor.clear

        return cell
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowPDF" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let destination = segue.destination as? PDFViewController
                destination?.statute = statutes[indexPath.row]
            }
        }
    }
    
     //FIXME: - UISearchBarDelegate
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchText == "" {
            APIService.shared.decodableJsonFromURL(jsonString: jsonString) { (statutes, isError) in

                // Show Message when have Error()
                self.setMessageURLError(isError: isError)

                // Get Data From json
                guard let statutes = statutes else { return }
                self.statutes = statutes
                self.tableView.reloadData()
            }
        }else{

            APIService.shared.decodableJsonFromURL(jsonString: jsonString) { (statutes, isError) in

                // Show Message when have Error()
                self.setMessageURLError(isError: isError)
                
                // Get Data From json
                guard let statutes = statutes else { return }
                let filteredStatutes = statutes.filter({$0.name.lowercased().contains(searchText.lowercased())})
                self.statutes = filteredStatutes

                self.tableView.reloadData()
            }

        }
    }

    
    // FIXME: - Action Method

    @IBAction func refreshTapped(_ sender: Any) {
        decodeJsonData()
    }

    

}


