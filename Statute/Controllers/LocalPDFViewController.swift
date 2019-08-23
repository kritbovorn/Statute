//
//  LocalPDFViewController.swift
//  Statute
//
//  Created by Kritbovorn on 10/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit
import PDFKit

class LocalPDFViewController: UIViewController {
    
    var pdfString: String?
    var pdfDocument: PDFDocument?
    var data = Data()
    
    @IBOutlet weak var pdfView: PDFView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let pdfString = pdfString else { return }
        
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        for file in fileManager {
            
            let pdfURL = file.appendingPathComponent(pdfString)
            
            if FileManager.default.fileExists(atPath: pdfURL.path) {
                do {
                    
                    data = try Data(contentsOf: pdfURL)
                
                    
                    pdfDocument = PDFDocument(url: pdfURL)
                    pdfView.document = pdfDocument
                    pdfView.autoScales = true
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func shareTapped(_ sender: Any) {
        
        guard let pdfString = pdfString else { return }
        
        let fileManager = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        for file in fileManager {

            let pdfURL = file.appendingPathComponent(pdfString)


            if FileManager.default.fileExists(atPath: pdfURL.path) {
                do {

                    data = try Data(contentsOf: pdfURL)
                    print("@@@ Data is", data)

                    let activityController = UIActivityViewController(activityItems: [pdfURL], applicationActivities: nil)
                    activityController.popoverPresentationController?.sourceView = view
                    present(activityController, animated: true, completion: nil)

                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        
        
        
        
        
        
    }
    
    
    

    

}
