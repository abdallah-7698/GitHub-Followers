//
//  GFSecondaryTitleLable.swift
//  GHFollowers
//
//  Created by MacOS on 26/07/2022.
//

import UIKit

class GFSecondaryTitleLable: UILabel {


        override init(frame:CGRect){
            super.init(frame: frame)
            configure()
         }
         
         required init?(coder: NSCoder) {
             fatalError("init(coder:) has not been implemented")
         }
    convenience init(fontSize : CGFloat){
              self.init(frame: .zero)
              self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
         }
         
         private func configure(){
             textColor                      = .secondaryLabel
             adjustsFontSizeToFitWidth      = true
             minimumScaleFactor             = 0.90
             // make the text dynamic
             lineBreakMode                  = .byTruncatingTail
             translatesAutoresizingMaskIntoConstraints = false
         }


}
