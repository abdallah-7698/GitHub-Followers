//
//  GFItemVC.swift
//  GHFollowers
//
//  Created by MacOS on 27/07/2022.
//

import UIKit

// this is the super class

class GFItemInfoVC: UIViewController {
    
    //MARK: - IBOutlet
    
    let stackView       = UIStackView()
    let itemInfoView1   = GFItemInfoView()
    let itemInfoView2   = GFItemInfoView()
    let actionButton    = GFButton()
    
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
        configureBackgrounView()
        configureActionButton()
        layoutUI()
        configureStackView()
    }
    
    //MARK: - HelperFunctions
    
   private func configureBackgrounView(){
        view.layer.cornerRadius  = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func  configureStackView(){
        stackView.axis = .horizontal
        //stackView.distribution = .equalSpacing
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoView1)
        stackView.addArrangedSubview(itemInfoView2)
    }
    
    private func configureActionButton(){
        actionButton.addTarget(self, action: #selector(actionButtonTaped), for: .touchUpInside)
    }
    
    // make it in the child bacause each one has different action
    @objc func actionButtonTaped(){ }
    
    private func layoutUI(){
        
        view.addSubviews(stackView , actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding : CGFloat = 12
        
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: view.topAnchor , constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor , constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        
        ])
        
    }
    
}
