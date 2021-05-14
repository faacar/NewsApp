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
    
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
        
        alertController.addAction(okeyAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func showEmptyStateView(title: String, message: String, imageString: String, in view: UIView) {
        let emptyStateView = NewsEmptyStateView(title: title, message: message, image: imageString)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
