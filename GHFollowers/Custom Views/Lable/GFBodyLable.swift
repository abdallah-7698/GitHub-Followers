//
//  GFBodyLable.swift
//  GHFollowers
//
//  Created by MacOS on 17/06/2022.
//

import UIKit

class GFBodyLable: UILabel {


    override init(frame:CGRect){
        super.init(frame: frame)
        configure()
     }
     
     required init?(coder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
    convenience init(textAlignment : NSTextAlignment){
          self.init(frame: .zero)
          self.textAlignment = textAlignment
     }
     
     private func configure(){
         textColor = .secondaryLabel
         adjustsFontSizeToFitWidth = true
         minimumScaleFactor = 0.75
         // make the text dynamic you can make it bigger from the app
         font = UIFont.preferredFont(forTextStyle: .body )
         adjustsFontForContentSizeCategory = true
         // if the text too long it will go to the next line or it willl but dots on the end of the line
         lineBreakMode = .byWordWrapping
         translatesAutoresizingMaskIntoConstraints = false
     }

}
