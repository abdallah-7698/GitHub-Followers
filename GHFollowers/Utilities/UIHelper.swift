//
//  UIHelper.swift
//  GHFollowers
//
//  Created by MacOS on 25/07/2022.
//

import UIKit

// you can't make empty one
enum UIHelper {
    
    // onlt for management the code to look better on FolloweListVC
    
    static func createLayout() -> UICollectionViewLayout {
        
        let size            = 0.333333334
        
        let itemSize        = NSCollectionLayoutSize(widthDimension: .fractionalWidth(size),
                              heightDimension: .fractionalHeight(1.0))
        let item            = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets  = .uniform(size: 2.5)
        
        let groupSize       = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                              heightDimension: .fractionalWidth(size))
        let group           = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section         = NSCollectionLayoutSection(group: group)
        
        let layout          = UICollectionViewCompositionalLayout(section: section)
        return layout
        
    }
    
}
