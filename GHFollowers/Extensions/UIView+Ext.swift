//
//  UIView+Ext.swift
//  GHFollowers
//
//  Created by MacOS on 29/07/2022.
//

import UIKit

extension UIView{
    // you can pass any number of views
    func addSubviews( _ views : UIView... ){
        views.forEach { addSubview($0)}
    }
    
    func pinToEdges(of superView : UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
}
