//
//  GFTextField.swift
//  GHFollowers
//
//  Created by MacOS on 17/06/2022.
//

import UIKit

class GFTextField: UITextField {

    override init(frame : CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius        = 10
        layer.borderWidth         = 2
        layer.borderColor         = UIColor.systemGray4.cgColor
        //black in dark mode and white on light mode
        textColor                 = .label
        tintColor                 = .label
        textAlignment             = .center
        font                      = UIFont.preferredFont(forTextStyle: .title2)
        // if the font too big it will make it smaller and fit
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        backgroundColor           = .tertiarySystemBackground
        autocorrectionType        = .no
        returnKeyType             = .go
        clearButtonMode           = .whileEditing
        placeholder               = "Enter a username"
    }
    
}
