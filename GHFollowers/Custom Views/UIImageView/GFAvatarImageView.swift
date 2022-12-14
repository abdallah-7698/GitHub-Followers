//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by MacOS on 21/06/2022.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = UIImage(named: Images.placeholder)
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds      = true
        image              = placeholderImage
        contentMode        = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(formURL url : String){
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {self.image = image }
        }
    }
    
}
