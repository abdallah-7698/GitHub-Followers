//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by MacOS on 26/07/2022.
//

import UIKit

class GFItemInfoView: UIView {
    
    enum itemInfoType{case repos , gists , followers , following}
    
    let symbolImageView = UIImageView()
    let titleLable    = GFTitleLable(textAlignment: .left, fontSize: 20)
    let countLable    = GFTitleLable(textAlignment: .center, fontSize: 20)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
             
        addSubviews(symbolImageView , titleLable , countLable)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            
            titleLable.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLable.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor , constant: 12),
            titleLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLable.heightAnchor.constraint(equalToConstant: 18),
            
            countLable.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLable.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLable.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    
    func set(itemInfoType : itemInfoType ,withCount count : Int){
        switch itemInfoType {
        case .repos:
            symbolImageView.image  = UIImage(systemName: SFSympols.repos)
            titleLable.text        = "Public Repos"
        case .gists:
            symbolImageView.image  = UIImage(systemName: SFSympols.gists)
            titleLable.text        = "Public Gists"
        case .followers:
            symbolImageView.image  = UIImage(systemName: SFSympols.followers)
            titleLable.text        = "Followers"
        case .following:
            symbolImageView.image  = UIImage(systemName: SFSympols.following)
            titleLable.text        = "Following"
        }
        countLable.text       = "\(count)"
    }
    
}
