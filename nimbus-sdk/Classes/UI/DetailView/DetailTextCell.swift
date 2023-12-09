//
//  DetailTextCell.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 06/09/23.
//

import UIKit

class DetailTextCell:  UITableViewCell {
    
    static let identifier = "DetailTextCell"
    
    private lazy var stackMain: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 5.0
        return stack
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 12.0)
        label.text = "[Title]"
        label.textColor = UIColor.appBlack
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 16.0)
        label.text = "[Description]"
        label.numberOfLines = 0
        label.textColor = UIColor.appBlack
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize() {
        self.backgroundColor = UIColor.white
        
        self.addSubview(stackMain)
        
        NSLayoutConstraint.activate([
            self.stackMain.topAnchor.constraint(equalTo: self.topAnchor, constant: 8.0),
            self.stackMain.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            self.stackMain.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            self.stackMain.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8.0),
        ])
        
        stackMain.addArrangedSubview(self.labelTitle)
        stackMain.addArrangedSubview(self.labelDescription)
        
        NSLayoutConstraint.activate([
            self.labelTitle.heightAnchor.constraint(equalToConstant: 16.0)
        ])
    }
    
    func setData(_ data: DetailCellData) {
        self.labelTitle.text = data.title
        self.labelDescription.text = data.data
    }
    
}
