//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by MacOS on 26/07/2022.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
    //MARK: - IBOutlet
    let avatarImageView     = GFAvatarImageView(frame: .zero)
    let userNameLable       = GFTitleLable(textAlignment: .left, fontSize: 34)
    let nameLable          = GFSecondaryTitleLable(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLable       = GFSecondaryTitleLable(fontSize: 18)
    let bioLable           = GFBodyLable(textAlignment: .left)
    
    //MARK: - Constant
    var user : User!
    
    //MARK: - init
    
    init(user : User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubviews(avatarImageView ,userNameLable,nameLable,locationImageView,locationLable , bioLable)
        layoutUI()
        configureUIElement()
    }
    
    
    //MARK: - HelperFunctions
    
    
    private func configureUIElement(){
        avatarImageView.downloadImage(formURL: user.avatarUrl)
        userNameLable.text          = user.login
        nameLable.text              = user.name ?? ""
        locationLable.text          = user.location ?? "No Location"
        bioLable.text               = user.bio ?? "no Bio Information"
        bioLable.numberOfLines      = 3
        locationImageView.image     = UIImage(systemName: SFSympols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    
    
    private func layoutUI(){
        let padding : CGFloat           = 20
        let textImageBadding : CGFloat  = 12
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor , constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            userNameLable.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            userNameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor , constant: textImageBadding),
            userNameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userNameLable.heightAnchor.constraint(equalToConstant: 38),
            
            nameLable.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor , constant: 8),
            nameLable.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImageBadding),
            nameLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLable.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImageBadding),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLable.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLable.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 12),
            locationLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLable.heightAnchor.constraint(equalToConstant: 20),
            
            bioLable.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImageBadding),
            bioLable.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLable.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLable.heightAnchor.constraint(equalToConstant: 90)
            
            
        ])
        
    }
    
}
