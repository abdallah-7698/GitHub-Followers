//
//  GFFollowerItemVC.swift
//  GHFollowers
//
//  Created by MacOS on 27/07/2022.
//

import UIKit


protocol GFFollowerItemVCDelegate : AnyObject {
    func didTapGetFollowers(for user : User)
}

class GFFollowerItemVC : GFItemInfoVC{
    
    weak var delegate : GFFollowerItemVCDelegate!

    init(user : User ,delegate : GFFollowerItemVCDelegate){
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoView1.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoView2.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroungColor: .systemGreen, title: "Get Followers")
    }
    
    override func actionButtonTaped() {
        guard user.followers != 0 else{
            presentGFAlertOnMainThread(title: "No Followes", message: "This user has no folloers . What a shame 😞.", buttonTitle: "So Sad")
            return
        }
        delegate.didTapGetFollowers(for: user)
        dismiss(animated: true)
    }
    
}
