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
    
    func decodableJsonFromURL(jsonString: String, completionHandler: @escaping ([Statute]?, URLError?) -> ()) {
        
        guard let url = URL(string: jsonString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                
                // เช็ค Error()
                if let urlErr = err {
                    let urlError = (urlErr as! URLError)
                    print("!!!!!!! Errrrrrrr = ", urlError.code)
                    
                    
                    completionHandler(nil, urlError)
                    return
                }
                
                //  Get data()
                guard let data = data else { return }
                
                do {
                    
                    let statutes = try JSONDecoder().decode([Statute].self, from: data)
                    
                    completionHandler(statutes, nil)
                    
                }catch let jsonErr {
                    print("mistake\(jsonErr.localizedDescription)")
                }
            }
            
            }.resume()
    }
}
