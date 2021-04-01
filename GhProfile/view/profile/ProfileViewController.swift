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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = ProfilePresenter(repo: RemoteRepo())

        setupView()
        presenter.fetchPinnedRepository()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        let lblName = UILabel()
        lblName.text = "Profile"
        view.addSubview(lblName)
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        view.addSubview(stackView)
        
        lblName.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalTo(view)
        }
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(lblName.snp.bottom).offset(8)
            make.left.equalTo(view)
            make.right.equalTo(view)
            make.bottom.equalTo(view)
        }
        
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(RepositoryCell.self, forCellReuseIdentifier: RepositoryCell.identifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        stackView.addArrangedSubview(tableView)
        
        tableView.snp.makeConstraints { (make) in
            make.height.equalTo(stackView.snp.height)
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryCell.identifier) as! RepositoryCell
        cell.fillWithData(title: "\(indexPath.row)")
        return cell
    }
    
    
}
