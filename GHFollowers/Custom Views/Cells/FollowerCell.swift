//
//  CollectionViewCell.swift
//  GHFollowers
//
//  Created by MacOS on 21/06/2022.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseID = "FollowerCell"
    
    var avatarImageView = GFAvatarImageView(frame: .zero)
    var usernameLable = GFTitleLable(textAlignment: .center, fontSize: 16)
    
    // make a view and pass him
    
    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower : Followers){
        usernameLable.text = follower.login
        avatarImageView.downloadImage(formURL: follower.avatarUrl)
    }
    
    
    
    private func configure(){
        
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        
        addSubview(avatarImageView)
        addSubview(usernameLable)
        
        let padding : CGFloat = 15
                
        NSLayoutConstraint.activate([
            
            view.topAnchor.constraint(equalTo: contentView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor , constant: 5),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 6),
            usernameLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            usernameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    

    
}
