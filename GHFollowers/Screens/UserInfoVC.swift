//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by MacOS on 26/07/2022.
//

import UIKit

protocol UserInfoVCDelegate : AnyObject {
    func didRequestFollowers(for userName : String)
}

class UserInfoVC: UIViewController {
    
    //MARK: - IBOutlet
    
    let headerView = UIView()
    let itemView1  = UIView()
    let itemView2  = UIView()
    let dateLable  = GFBodyLable(textAlignment: .center)
    var itemViews : [UIView] = []
    
    // the design don't work good on the small device ike iphone 6 so we will make this screen scroll view
    let scrollView = UIScrollView()
    let contantView = UIView()
    
    //MARK: - Constant
    
    private var userName : String!
    weak var delegate : UserInfoVCDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        configureScrollView()
        layoutUI()
        getUser()
    }
    
    init(userName:String){
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - HelperFunctions
    
    private func configureNavigation(){
        
        view.backgroundColor = .systemBackground
        
        navigationController?.navigationBar.tintColor           = .systemGreen
        navigationController?.navigationBar.isTranslucent       = true
        navigationController?.navigationBar.backgroundColor     = UIColor.systemGray6
        
        navigationController?.navigationBar.layer.masksToBounds = false
        navigationController?.navigationBar.layer.shadowColor   = UIColor.lightGray.cgColor
        navigationController?.navigationBar.layer.shadowOpacity = 0.9
        navigationController?.navigationBar.layer.shadowOffset  = CGSize(width: 0, height: 1.0)
        navigationController?.navigationBar.layer.shadowRadius  = 1
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func getUser(){
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let user):
                DispatchQueue.main.async {self.configureUIElements(with: user)}
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    func configureUIElements(with user : User){
        
        
        let repoItemVC = GFRepoItemVC(user: user , delegate: self)
        let followerItemVC = GFFollowerItemVC(user: user,delegate: self)
        
        // but the viewController on the View you crated
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.add(childVC: repoItemVC, to: self.itemView1)
        self.add(childVC: followerItemVC, to: self.itemView2)
        self.dateLable.text = "GitHub since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    private func configureScrollView(){
        view.addSubviews(scrollView)
        scrollView.addSubviews(contantView)
       
        scrollView.pinToEdges(of: view)
        contantView.pinToEdges(of: scrollView)
        NSLayoutConstraint.activate([
            contantView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contantView.heightAnchor.constraint(equalToConstant: 600)
        ])
    }
    
    private func layoutUI(){
        
        let padding : CGFloat = 20
        let itemHeight : CGFloat = 140
        
        itemViews = [headerView , itemView1 , itemView2 , dateLable]
        
        itemViews.forEach {
            contantView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                $0.leadingAnchor.constraint(equalTo: contantView.leadingAnchor , constant: padding),
                $0.trailingAnchor.constraint(equalTo: contantView.trailingAnchor , constant: -padding)
            ])
            
        }
        
        headerView.backgroundColor = .systemBackground
        dateLable.font = UIFont.systemFont(ofSize: 25)
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contantView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemView2.topAnchor.constraint(equalTo: itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLable.topAnchor.constraint(equalTo: itemView2.bottomAnchor , constant: padding),
            dateLable.heightAnchor.constraint(equalToConstant: 20)
            
        ])
    }
    
    private func add(childVC : UIViewController , to containerView : UIView){
        // make the ViewController child
        // but the content of the view Controller on the View
        // but the childView on the frame on smaller size
        // make the parent that controlles the childVC is this View Controller
        addChild(childVC)
        containerView.addSubview(childVC.view)
        // make the ViewController fill the whole contaienr View
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
}


extension UserInfoVC : GFFollowerItemVCDelegate , GFRepoItemVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The URL attached to the user is invalid", buttonTitle: "Ok")
            return
        }
        presentSafareVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        print(user.login)
        delegate.didRequestFollowers(for: user.login)
    }

    
}
