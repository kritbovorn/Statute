//
//  StatuteTableViewCell.swift
//  Statute
//
//  Created by Kritbovorn on 16/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

class StatuteTableViewCell: UITableViewCell {
    
    let imageLogoString = "https://drive.google.com/uc?export=download&id=1KK8awkgdIBHsxweZTXgCqzYxS_a2c92l"

    @IBOutlet weak var statuteImageView: UIImageView!
    
    @IBOutlet weak var statuteNameLabel: UILabel!
    
    
    var statute: Statute! {
        didSet {
            
            statuteNameLabel.text = statute.name
//            statuteLinkLabel.textColor = UIColor(red: 119/255, green: 119/255, blue: 119/255, alpha: 1.0)
//            statuteLinkLabel.text = statute.address
            statuteNameLabel.textColor = UIColor(red: 163/255, green: 163/255, blue: 163/255, alpha: 1.0)
            
        
            
            guard let imageURL = URL(string: imageLogoString) else { return }
            
            URLSession.shared.dataTask(with: imageURL) { (data, respponse, err) in
                if let error = err {
                    print("Error: ", error.localizedDescription)
                }
                
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    self.statuteImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
}
