//
//  APIService.swift
//  Statute
//
//  Created by Kritbovorn on 15/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

class APIService {
    
    static let shared = APIService()
    
//    let jsonString = "https://tyre.in.th/Statute/JsonStat.php"
    //let jsonString = "https://tyre.in.th/Statute/JsonStatute.php"
    
    func decodableJsonFromURL(jsonString: String, completionHandler: @escaping ([Statute]) -> ()) {
        
        guard let url = URL(string: jsonString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                if let error = err {
                    print("error\(error.localizedDescription)")
                }
                
                guard let data = data else { return }
                
                print("This is data:", data)
                
                do {
                    
                    let statutes = try JSONDecoder().decode([Statute].self, from: data)
                    
        
                    completionHandler(statutes)
//                    let filteredStatutes = self.statutes.filter({$0.name.lowercased().contains(searchText.lowercased())})
//                    self.statutes = filteredStatutes
//                    self.tableView.reloadData()
        
                    
                }catch let jsonErr {
                    print("mistake\(jsonErr.localizedDescription)")
                }
            }
            
            }.resume()
    }
}
