//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by MacOS on 17/06/2022.
//

import UIKit

class FollowerListVC: GFDataLoadingVC {
    
    
    // the value of the UICollectionViewDiffableDataSource must be hashable and enum is hashable by default
    // so we but it on the enum and if you had two section you can make two cases
    
    //MARK: - Constant
    
    enum Section{case main}
    
    
    var userName  : String!
    var followers : [Followers] = []
    var filterFollowers : [Followers] = []
    var page : Int = 1
    
    var hasMoreFollowers = true
    
    var isLoadingMoreFollowers = false
    
    var collectionView : UICollectionView!
    var dataSource     : UICollectionViewDiffableDataSource<Section,Followers>!
    
    //MARK: - View
    
    init(userName : String){
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
        title = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        configureCollectioView()
        configureSearchController()
        getFollowers(userName: userName, page: page)
        configureDataSourse()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // it will not be hidden when you swap it from navigation to another
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - HelperFunctions
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .systemGreen
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    func configureCollectioView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView?.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        collectionView.delegate = self
    }
    
    func configureSearchController(){
        let searchController                                  = UISearchController()
        searchController.searchResultsUpdater                 = self
        // to remove the shadow color that appears when click on the search controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder                = "Search for UserName"
        navigationItem.searchController                       = searchController
    }
    
    func getFollowers(userName : String , page : Int){
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bag Stuff Happend", message: error.rawValue, buttonTitle: "Ok")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    func updateUI(with followers : [Followers]){
        self.dismissLoadingView()
        if followers.count < 100 {self.hasMoreFollowers = false}
        //  self.followers = followers --> if you get the page 2 it will remove the last array
        self.followers.append(contentsOf : followers)
        // if no one show message
        if self.followers.isEmpty {
            let message = "This user has no followers. Go follow him 😁."
            DispatchQueue.main.async {self.showEmptyStateView(with: message, inView: self.view)}
            return
        }
        self.updateData(on: self.followers)
        
    }
    
    //MARK: - only use diffable data sourse when your collectionView is dynamic if it is simple use the old way
    
    // when we created it we dont give it the data it still not have the Followers it only know the shape of the cell not have the data
    func configureDataSourse(){
        dataSource = UICollectionViewDiffableDataSource<Section , Followers>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    // every time we want to get a snapShot from the data we call this func
    // it pass the data to the UICollectionViewDiffableDataSource
    func updateData(on followers : [Followers]){
        var snapshot = NSDiffableDataSourceSnapshot<Section , Followers>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        // more safe (apple say)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)}
    }
    
    //MARK: - IBAction
    @objc func addButtonTapped(){
        // in this bage we don't have avatarURL son we make the call to get that only
        NetworkManager.shared.getUserInfo(for: userName) {[weak self] result in
            guard let self = self else {return}
            // self.dismissLoadingView()
            switch result{
            case .success(let user):
                self.addUserToFavorite(user: user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "oK")
            }
        }
    }
    
    func addUserToFavorite(user : User){
        let favourite  = Followers(login: user.login, avatarUrl: user.avatarUrl)
        PersistenceManager.update(with: favourite, actionType: .add) {[weak self] error in
            guard let self = self else {return}
            guard let error = error else {
                self.presentGFAlertOnMainThread(title: "Success", message: "You have successfully favourited this user🥳", buttonTitle: "oK")
                return
            }
            self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "oK")
        }
    }
    
}

//MARK: - Extensions

extension FollowerListVC : UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        // you must do some math ot know when did you get to the bottom of the screen
        // offset y updates when you scroll dwon and the oter two values not
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        // if you want to see them in action print them
        // it will get n error if the user has no more follower
        if offsetY > contentHeight - height {
            guard hasMoreFollowers , !isLoadingMoreFollowers else{return}
            page += 1
            // there is a problem that the user don't get teh next bage followers and the alst bage don't downloaded yet  --> !isLoadingMoreFollowers
            // so if you has bad connection the app will not crash
            getFollowers(userName: userName , page: page)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = navigationItem.searchController!.isActive ? filterFollowers[indexPath.row] : followers[indexPath.row]
        let destVC = UserInfoVC(userName: follower.login)
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
        
    }
    
}


extension FollowerListVC : UISearchResultsUpdating {
    // it called when the usr type any thing
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,!filter.isEmpty else{
            filterFollowers.removeAll()
            updateData(on: followers)
            return}
        filterFollowers = followers.filter{$0.login.lowercased().contains(filter.lowercased())}
        // if you cancel the search bar it will remail and will not change
        updateData(on: filterFollowers)
    }
    
}

extension FollowerListVC : UserInfoVCDelegate{
    func didRequestFollowers(for userName: String) {
        self.userName = userName
        print(userName)
        title = userName
        self.page = 1
        followers.removeAll()
        //the last line don't work good
        //        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at:  IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(userName: userName, page: page)
    }
}
