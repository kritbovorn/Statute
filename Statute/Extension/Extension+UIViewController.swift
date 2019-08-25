//
//  Extension+UIViewController.swift
//  Statute
//
//  Created by Kritbovorn on 25/8/2562 BE.
//  Copyright © 2562 Kritbovorn. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func setupIndicatorView() {
        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        indicatorView.color = .black
        indicatorView.startAnimating()
        indicatorView.center = view.center
        indicatorView.tag = 1
        
        view.addSubview(indicatorView)
    }
    
    func hideIndicatorView() {
        let indicatorView = view.viewWithTag(1) as? UIActivityIndicatorView
        indicatorView?.isHidden = true
        indicatorView?.stopAnimating()
        indicatorView?.removeFromSuperview()
    }
}
