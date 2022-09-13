//
//  GFAlertVC.swift
//  GHFollowers
//
//  Created by MacOS on 18/06/2022.
//

import UIKit

class GFAlertVC: UIViewController {

    let containerView   = GFAlertContainerView()
    let titleLable      = GFTitleLable(textAlignment: .center, fontSize: 20)
    let messageLable    = GFBodyLable(textAlignment: .center)
    let actionButton    = GFButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle : String?
    var message : String?
    var buttonTitle : String?
    let padding : CGFloat = 20
    
    init(title : String , message : String , buttonTitle : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle  = title
        self.message     = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureContainerView()
        configureTitleLable()
        configureActionButton()
        configureMessageLable()
    }
    
    func configureContainerView(){
        view.addSubviews(containerView , titleLable , actionButton , messageLable)
     
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            containerView.widthAnchor.constraint(equalToConstant: 280)
        ])
    }
    
    func configureTitleLable(){
        titleLable.text = alertTitle ?? "some thing went wrong"
        NSLayoutConstraint.activate([
            titleLable.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLable.heightAnchor.constraint(equalToConstant: 28)
        ])
    }

    // we want to make our button first then make the text between so you must make the button first
    
    func configureActionButton(){
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
       
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    func configureMessageLable(){
        messageLable.text = message ?? "unable to complete request"
        messageLable.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageLable.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 8),
            messageLable.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLable.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLable.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }

}
