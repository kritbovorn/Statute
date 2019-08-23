//
//  PDFViewController.swift
//  Statute
//
//  Created by Kritbovorn on 10/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.


//      Temporary Document
//  https://nshipster.com/temporary-files/
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var statute: Statute?
    
    var pdfDocument: PDFDocument?
    
    var documentFileURL: URL?
    
    var pdfData = Data()
    
    @IBOutlet weak var pdfView: PDFView!
    
    @IBOutlet weak var save: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = false
        presentPDF()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let statuteName = statute?.name else { return }
        
        
        
        let fileName = "\(statuteName).pdf"
        
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentFileURL = fileManager.appendingPathComponent(fileName)
        
        if FileManager.default.fileExists(atPath: documentFileURL?.path ?? "") {
            save.isEnabled = false
        }
        
        
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.autoScales = true
    }
    
    // FIXME: -  แสดง  PDF
    func presentPDF() {
        guard let url = URL(string: statute?.address ?? "") else { return }
        pdfDocument = PDFDocument(url: url)
        
        pdfView.document = pdfDocument
        
    }
    
    // FIXME: - Action Methods
    
    @IBAction func saveTapped(_ sender: Any) {
        
        var data = Data()
        
        guard let statuteName = statute?.name else { return }
        guard let statuteLink = statute?.address else { return }
        guard let url = URL(string: statuteLink) else { return }
        
        let fileName = "\(statuteName).pdf"
        
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        documentFileURL = fileManager.appendingPathComponent(fileName)
        
        //  เช็คว่า ถ้ามี File อยู่
        if FileManager.default.fileExists(atPath: documentFileURL?.path ?? "") {
            save.isEnabled = false
        }else{
            do {
                data = try Data(contentsOf: url)
                try data.write(to: documentFileURL!)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.save.isEnabled = false
                    
                    //  Save เสร็จ ข้ามไปหน้า Tabbar อื่น
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavoriteCollectionViewController") as? FavoriteCollectionViewController else { return }
                    let tabTwoView = self.tabBarController?.viewControllers?[1] as! UINavigationController
                    tabTwoView.pushViewController(vc, animated: true)
                    
                    self.tabBarController?.selectedIndex = 1
                    
                    
                }
            }catch let err{
                print(err.localizedDescription)
            }
            
        }
    }
    
    @IBAction func share(_ sender: Any) {
        
        guard let pdfString = statute?.name else { return }
        guard let pdfLinkString = statute?.address else { return }
        guard let url = URL(string: pdfLinkString) else { return }
        
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        //print("@@@@@@@@@ Temporary is ", temporaryDirectoryURL)
        let temporaryPath = temporaryDirectoryURL.appendingPathComponent("\(pdfString).pdf")
        //print("######### Temp Path is", temporaryPath.path)
        
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
            }

            guard let data = data else { return }
            

            do {
                
                
                try data.write(to: temporaryPath)
                
                    
                    let activityController = UIActivityViewController(activityItems: [temporaryPath], applicationActivities: nil)
                    activityController.popoverPresentationController?.sourceView = self.view
                    
                    self.present(activityController, animated: true, completion: nil)
                
                

            }catch let er{
                print("Error: \(er.localizedDescription)")
            }
        }.resume()
        

        

    }
       
    
    
    
}
