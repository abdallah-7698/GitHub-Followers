//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by MacOS on 27/07/2022.
//

import UIKit

protocol GFRepoItemVCDelegate : AnyObject {
    func didTapGitHubProfile(for user : User)

}

class GFRepoItemVC : GFItemInfoVC {
    
    weak var delegate : GFRepoItemVCDelegate!

    
    init(user : User , delegate : GFRepoItemVCDelegate){
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
        itemInfoView1.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoView2.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroungColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTaped() {
        delegate.didTapGitHubProfile(for: user)
    }

}
