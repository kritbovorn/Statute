//
//  HistoryCollectionViewCell.swift
//  Statute
//
//  Created by Kritbovorn on 20/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

class HistoryCollectionViewCell: UICollectionViewCell {
    
    
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "logoStatute"))
    let nameLabel = UILabel()
    //let addressLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        

        
        //nameLabel.text = "พระราชบัญญัติการออมแห่งชาติ"
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.numberOfLines = 0
        nameLabel.textColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
//        addressLabel.text = "กฤตบวร ทวียศศักดิ์"
//        addressLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
//        addressLabel.textColor = UIColor(red: 232/255, green: 232/255, blue: 232/255, alpha: 1.0)
        
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        //imageView.backgroundColor = UIColor(red: 255/255, green: 128/255, blue: 1/255, alpha: 1.0)
        
        let stackView = UIStackView(arrangedSubviews: [imageView, nameLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
