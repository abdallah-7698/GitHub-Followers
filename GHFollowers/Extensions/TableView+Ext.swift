//
//  TableView+Ext.swift
//  GHFollowers
//
//  Created by MacOS on 29/07/2022.
//

import UIKit


extension UITableView{
    func reloadDataOnMainThred(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
