//
//  GFButton.swift
//  GHFollowers
//
//  Created by MacOS on 17/06/2022.
//

import UIKit

class GFButton: UIButton {
// make the init with the frame
    override init(frame: CGRect) {
        // the super take sure that this will happen first
        super.init(frame: frame)
        configure()
    }
    
    // this must be here if the button has been init with storyBoard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor : UIColor, title : String){
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configure(){
        layer.cornerRadius    = 10
        // it make our tite to be bold
        titleLabel?.font      = UIFont.preferredFont(forTextStyle: .headline)
        setTitleColor(.white , for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroungColor : UIColor , title : String){
        self.backgroundColor = backgroungColor
        setTitle(title, for: .normal)
    }
    
}
