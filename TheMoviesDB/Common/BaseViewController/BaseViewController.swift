//
//  BaseViewController.swift
//  TheMoviesDB
//
//  Created by Dylan Trujillo on 02/11/2020.
//

import UIKit

class BaseViewController: UIViewController {
    var backgroundView: UIView = {
        let view: UIView = UIView()
        view.backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        view.isUserInteractionEnabled = false
        return view
    }()
    var activityView = UIActivityIndicatorView()
    
    func showLoading(background: Bool = false) {
        if background {
            backgroundView.frame = view.bounds
            view.addSubview(backgroundView)
        }
        activityView = UIActivityIndicatorView(style: .medium)
        activityView.center = self.view.center
        activityView.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(activityView)
    }
    
    func hideLoading() {
        backgroundView.removeFromSuperview()
        activityView.stopAnimating()
        activityView.removeFromSuperview()
        self.view.alpha = 1
        self.view.isUserInteractionEnabled = true
    }
    
    func showErrorAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: LocalizableKeys.ok.localized, style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
}
