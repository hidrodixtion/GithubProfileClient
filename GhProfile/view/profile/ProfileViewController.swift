//
//  ProfileViewController.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    var presenter: ProfilePresenter!
    
    private var pinnedRepositories: [RepositoryModel] = []
    
    /// UI
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenter(repo: RemoteRepo())
        presenter.delegate = self

        setupView()
        presenter.fetchPinnedRepository()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        let lblName = UILabel()
        lblName.text = "Profile"
        view.addSubview(lblName)
        
        lblName.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalTo(view)
        }
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(lblName.snp.bottom).offset(16)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view).offset(-16)
        }
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
    func onDataFetched(list: [RepositoryModel]) {
        pinnedRepositories = list
        tableView.reloadData()
    }
    
    func onError(error: Error) {
        print(error.localizedDescription)
    }
}
