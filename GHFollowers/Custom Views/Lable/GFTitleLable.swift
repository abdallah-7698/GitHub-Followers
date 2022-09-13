//
//  GFTitleLable.swift
//  GHFollowers
//
//  Created by MacOS on 17/06/2022.
//

import UIKit

class GFTitleLable: UILabel {

   override init(frame:CGRect){
       super.init(frame: frame)
       configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // we dont want to make the font resize or font text style because the font will not change on the title
    // convenience init wil call the initial init and make the cide on it first
    convenience init(textAlignment : NSTextAlignment , fontSize : CGFloat ){
         self.init(frame: .zero)
         self.textAlignment = textAlignment
         self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    private func configure(){
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        // if the text too long it will go to the next line or it willl but dots on the end of the line
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
