//
//  UIViewController+Ext.swift
//  NewsApp
//
//  Created by Ahmet Acar on 10.05.2021.
//

import UIKit

fileprivate var containerView: UIView?

extension UIViewController {
    
    func showLoadingView() {
        containerView = UIView(frame: self.view.bounds)
        containerView?.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.5)

        //containerView?.alpha = 0.5
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = containerView!.center
        activityIndicator.startAnimating()
        
        containerView?.addSubview(activityIndicator)
        self.view.addSubview(containerView!)
    }
    
    func dismissLoadingView() {
        containerView?.removeFromSuperview()
        containerView = nil
    }
}
