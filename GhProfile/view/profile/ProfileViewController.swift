//
//  ProfileViewController.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import UIKit
import SnapKit
import Kingfisher

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenter!
    
    private var pinnedRepositories: [RepositoryModel] = []
    
    /// UI
    var tableView: UITableView!
    var imgProfile: UIImageView!
    var lblName: UILabel!
    var lblLogin: UILabel!
    var lblEmail: UILabel!
    var lblFollower: UILabel!
    var lblFollowing: UILabel!
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenter(repo: AppRepository())
        presenter.delegate = self

        setupView()
        presenter.fetchPinnedRepository()
        presenter.fetchProfile()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        let lblTitle = UILabel()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 24)
        lblTitle.text = "Profile"
        view.addSubview(lblTitle)
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalTo(view)
        }
        
        let imageSize = 88
        imgProfile = UIImageView()
        imgProfile.layer.cornerRadius = CGFloat(imageSize/2)
        imgProfile.layer.masksToBounds = true
        view.addSubview(imgProfile)
        imgProfile.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottom).offset(24)
            make.left.equalTo(view).offset(16)
            make.width.height.equalTo(imageSize)
        }
        
        lblName = UILabel()
        lblName.font = UIFont.boldSystemFont(ofSize: 24)
        view.addSubview(lblName)
        lblName.snp.makeConstraints { (make) in
            make.centerY.equalTo(imgProfile)
            make.left.equalTo(imgProfile.snp.right).offset(8)
            make.right.equalTo(view).offset(-16)
        }
        
        lblLogin = UILabel()
        view.addSubview(lblLogin)
        lblLogin.snp.makeConstraints { (make) in
            make.top.equalTo(lblName.snp.bottom)
            make.left.equalTo(lblName)
        }
        
        lblEmail = UILabel()
        lblEmail.font = UIFont.boldSystemFont(ofSize: 16)
        view.addSubview(lblEmail)
        lblEmail.snp.makeConstraints { (make) in
            make.left.equalTo(imgProfile)
            make.top.equalTo(imgProfile.snp.bottom).offset(16)
        }
        
        lblFollower = UILabel()
        view.addSubview(lblFollower)
        lblFollower.snp.makeConstraints { (make) in
            make.left.equalTo(lblEmail)
            make.top.equalTo(lblEmail.snp.bottom).offset(8)
        }
        
        lblFollowing = UILabel()
        view.addSubview(lblFollowing)
        lblFollowing.snp.makeConstraints { (make) in
            make.top.equalTo(lblFollower)
            make.left.equalTo(lblFollower.snp.right).offset(16)
        }
        
        let lblPinned = UILabel()
        lblPinned.text = "Pinned Repositories"
        lblPinned.font = .boldSystemFont(ofSize: 16)
        view.addSubview(lblPinned)
        lblPinned.snp.makeConstraints { (make) in
            make.top.equalTo(lblFollower.snp.bottom).offset(16)
            make.left.equalTo(lblFollower)
        }
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(lblPinned.snp.bottom).offset(16)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view).offset(-16)
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh!")
        refreshControl.addTarget(self, action: #selector(forceRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func forceRefresh() {
        presenter.fetchPinnedRepository(forceFetch: true)
        refreshControl.endRefreshing()
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pinnedRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier) as! RepositoryCell
        let data = pinnedRepositories[indexPath.row]
        cell.fillWithData(data: data)
        return cell
    }
    
}

extension ProfileViewController: ProfilePresenterDelegate {
    func onPinnedRepositoryFetched(list: [RepositoryModel]) {
        pinnedRepositories = list
        tableView.reloadData()
    }
    
    func onUserDataFetched(user: User) {
        lblName.text = user.name
        lblLogin.text = user.login
        lblEmail.text = user.email
        lblFollower.text = "\(user.follower) Follower"
        lblFollowing.text = "\(user.following) Following"
        
        imgProfile.kf.setImage(with: URL(string: user.avatarUrl))
    }
    
    func onError(error: Error) {
        print(error.localizedDescription)
    }
}
