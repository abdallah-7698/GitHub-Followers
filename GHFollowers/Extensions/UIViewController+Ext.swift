//
//  UIViewController+Ext.swift
//  GHFollowers
//
//  Created by MacOS on 18/06/2022.
//

import UIKit
import SafariServices
// tou can't access this var outside thes file

extension UIViewController{
    func presentGFAlertOnMainThread(title : String , message : String ,buttonTitle : String){
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle   = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func presentSafareVC(with url : URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
}

extension NSDirectionalEdgeInsets {
    static func uniform(size: CGFloat) -> NSDirectionalEdgeInsets {
        return NSDirectionalEdgeInsets(top: size, leading: size, bottom: size, trailing: size)
    }
}
