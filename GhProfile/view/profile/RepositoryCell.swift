//
//  RepositoryCell.swift
//  GhProfile
//
//  Created by Adi Nugroho on 01/04/21.
//

import UIKit

class RepositoryCell: UITableViewCell {

    static let identifier = "kRepositoryCell"
    
    var lblTitle: UILabel!
    var lblSubtitle: UILabel!
    var lblStar: UILabel!
    var viewLanguageIcon: UIView!
    var lblLanguage: UILabel!
    
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
        border.layer.borderColor = UIColor.lightGray.cgColor
        border.layer.cornerRadius = 16
        contentView.addSubview(border)
        border.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 16, bottom: 8, right: 16))
        }
        
        lblTitle = UILabel()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        border.addSubview(lblTitle)
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalTo(border).offset(32)
            make.left.equalTo(border).offset(32)
        }
        
        lblSubtitle = UILabel()
        lblSubtitle.font = UIFont.systemFont(ofSize: 16)
        lblSubtitle.numberOfLines = 2
        border.addSubview(lblSubtitle)
        lblSubtitle.snp.makeConstraints { (make) in
            make.top.equalTo(lblTitle.snp.bottom).offset(2)
            make.left.equalTo(lblTitle)
            make.right.equalTo(border).offset(-32)
        }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .fill
        stackView.distribution = .fill
        border.addSubview(stackView)
        
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(lblSubtitle.snp.bottom).offset(22)
            make.left.equalTo(lblTitle)
            make.bottom.equalTo(border).offset(-32)
        }
        
        let imgStar = UIImageView(image: UIImage(named: "star"))
        imgStar.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(imgStar)
        imgStar.snp.makeConstraints { (make) in
            make.width.equalTo(14)
        }
        
        lblStar = UILabel()
        lblStar.font = UIFont.systemFont(ofSize: 14)
        stackView.addArrangedSubview(lblStar)
        
        let emptyView0 = UIView()
        emptyView0.snp.makeConstraints { (make) in
            make.width.height.equalTo(12)
        }
        stackView.addArrangedSubview(emptyView0)
        
        viewLanguageIcon = UIView()
        viewLanguageIcon.layer.cornerRadius = 6
        stackView.addArrangedSubview(viewLanguageIcon)
        viewLanguageIcon.snp.makeConstraints { (make) in
            make.width.height.equalTo(12)
        }
        
        lblLanguage = UILabel()
        lblLanguage.font = UIFont.systemFont(ofSize: 14)
        stackView.addArrangedSubview(lblLanguage)
    }

    func fillWithData(data: RepositoryModel) {
        lblTitle.text = data.name
        lblSubtitle.text = data.description
        lblStar.text = "\(data.starCount)"
        lblLanguage.text = data.primaryLanguage.name
        viewLanguageIcon.backgroundColor = data.primaryLanguage.color.hexColor
    }
}
