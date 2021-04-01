//
//  ProfileViewController.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import UIKit
import SnapKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    func setupView() {
        view.backgroundColor = UIColor.white
        let lblName = UILabel()
        lblName.text = "Profile"
        view.addSubview(lblName)
        
        lblName.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(8)
            make.centerX.equalTo(view).offset(0)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
