//
//  RepositoryCell.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import UIKit

class RepositoryCell: UITableViewCell {

    static let identifier = "kRepositoryCell"
    
    var label: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView() {
        contentView.autoresizingMask = .flexibleHeight
        
        let border = UIView()
        border.layer.borderWidth = 1
        border.layer.borderColor = UIColor.darkGray.cgColor
        border.layer.cornerRadius = 16
        contentView.addSubview(border)
        border.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 8, bottom: 8, right: 8))
        }
        
        label = UILabel()
        border.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(border).offset(16)
            make.left.equalTo(border).offset(8)
            make.bottom.equalTo(border).offset(-16)
        }
    }

    func fillWithData(title: String) {
        label.text = title
    }
}
