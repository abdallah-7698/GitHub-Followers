//
//  FavouriteCell.swift
//  GHFollowers
//
//  Created by MacOS on 28/07/2022.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let reuseID = "FavouriteCell"
    var avatarImageView = GFAvatarImageView(frame: .zero)
    var usernameLable = GFTitleLable(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favourite : Followers){
        usernameLable.text = favourite.login
        avatarImageView.downloadImage(formURL: favourite.avatarUrl)
    }
    
    private func configure(){
       addSubview(avatarImageView)
        addSubview(usernameLable)
        self.accessoryType = .disclosureIndicator
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
        
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            usernameLable.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLable.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
}
