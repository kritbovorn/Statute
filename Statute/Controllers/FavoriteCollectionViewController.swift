//
//  HistoryCollectionViewController.swift
//  Statute
//
//  Created by Kritbovorn on 20/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class FavoriteCollectionViewController: UICollectionViewController {

    var pdfArray = [String]()
    var fileString = ""
    
    
    // FIXME: - View ()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupCollectionView()
        setupFileManager()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        pdfArray = [String]()
        
        setupFileManager()
        collectionView.reloadData()
    }
    
    // FIXME: - Setup CollectionView
    
    fileprivate func setupCollectionView() {
        
        title = "พรบ ที่ บันทึกไว้"

        self.collectionView!.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.backgroundColor = UIColor(red: 40/255, green: 42/255, blue: 54/255, alpha: 1.0)
    }
    
    
    
    // FIXME: - Setup FileManager()
    
    fileprivate func setupFileManager() {
        
        let fileManagerURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        do {
            let fileURLDocuments = try FileManager.default.contentsOfDirectory(at: fileManagerURL, includingPropertiesForKeys: nil, options: [])
            let filterFilePathURLs = fileURLDocuments.filter { $0.pathExtension == "pdf" }
            
            filterFilePathURLs.forEach { (filterFile) in
                let fileString = filterFile.lastPathComponent
                
                self.pdfArray.append(fileString)
            }
            
        }catch let fileErr {
            print(fileErr)
        }
    }

    

    // MARK: UICollectionViewDataSource


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return pdfArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HistoryCollectionViewCell
    
        cell.nameLabel.text = pdfArray[indexPath.item]
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowLocalPDF", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowLocalPDF" {
            if let indexPaths = collectionView.indexPathsForSelectedItems {
                let indexPath = indexPaths[0]
                let destination = segue.destination as? LocalPDFViewController
                destination?.pdfString = pdfArray[indexPath.item]
            }
        }
    }
}

extension FavoriteCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (view.frame.width - (16 * 3)) / 2
        
        return CGSize(width: width, height: width + 115)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
