//
//  ViewController.swift
//  Statute
//
//  Created by Kritbovorn on 20/7/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit
import PDFKit

class ViewController: UIViewController {

    let pdfString = "https://drive.google.com/uc?export=download&id=1LgVo94Gnb5adNUoKz5Q1B7rrN6Pc31jS"
    
    //let pdfString = "https://www.tutorialspoint.com/swift/swift_tutorial.pdf"
    
    
    
    @IBOutlet weak var pdfView: PDFView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        guard let pdfURL = URL(string: pdfString) else { return }
        
        let pdfDocument = PDFDocument(url: pdfURL)
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        
        
    }
}

