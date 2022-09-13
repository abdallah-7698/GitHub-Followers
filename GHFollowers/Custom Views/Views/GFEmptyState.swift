//
//  GFEmptyState.swift
//  GHFollowers
//
//  Created by MacOS on 25/07/2022.
//

import UIKit

class GFEmptyState: UIView {
    
    let messageLable = GFTitleLable(textAlignment: .center, fontSize: 28)
    let imageLogo    = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message : String){
        self.init(frame: .zero)
        messageLable.text = message
    }
    
    private func configure(){
        configureMessageLable()
        configureLogoImage()
    }
    
    private func configureLogoImage(){
        
        addSubview(imageLogo)
        
        imageLogo.image            = UIImage(named: Images.emptyState)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        
        var logoBottomConstant : CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE1 ? 100 : 40
        logoBottomConstant = UIDevice.current.screenType == .iPhones_6_6s_7_8_SE2 ? 60 : 40
        
        NSLayoutConstraint.activate([
            imageLogo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLogo.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            imageLogo.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            imageLogo.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
            
        ])
    }
    
    private func configureMessageLable(){
        
        addSubview(messageLable)
        
        messageLable.numberOfLines = 3
        messageLable.textColor     = .secondaryLabel
        
        var LableCenterYConstant : CGFloat = UIDevice.current.screenType == .iPhones_5_5s_5c_SE1 ? -90 : -150
        LableCenterYConstant = UIDevice.current.screenType == .iPhones_6_6s_7_8_SE2 ? -100 : -150
        
        NSLayoutConstraint.activate([
            messageLable.centerYAnchor.constraint(equalTo: self.centerYAnchor , constant: LableCenterYConstant),
            messageLable.leadingAnchor.constraint(equalTo: self.leadingAnchor , constant: 40),
            messageLable.trailingAnchor.constraint(equalTo: self.trailingAnchor , constant: -40),
            messageLable.heightAnchor.constraint(equalToConstant: 200),
            
        ])
        
    }
    
    
}
