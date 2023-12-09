//
//  InstrumentationViewCell.swift
//  NimbusMonitor
//
//  Created by Abhishek Ravi on 07/09/23.
//

import Foundation

public class InstrumentationViewCell: UITableViewCell {
    
    static let identifier = "InstrumentationViewCell"
    
    private lazy var stackMain: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .vertical
        stack.spacing = 4.0
        return stack
    }()
    
    private lazy var labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Black", size: 16.0)
        label.text = "[Label Title]"
        return label
    }()
    
    private lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 16.0)
        label.text = "[Label Description]"
        return label
    }()
    
    private lazy var labelFooter: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Medium", size: 12.0)
        label.text = "[Label Date]"
        return label
    }()
    
    private lazy var viewTag: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var labelTagTitle: UILabel = {
        let label = UILabel()
        label.text = "debug"
        label.font = UIFont(name: "Avenir-Medium", size: 10.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackTitle: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        return stack
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        intialize()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        intialize()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.viewTag.layer.cornerRadius = self.viewTag.bounds.height / 2
    }
    
    func intialize() {
        self.backgroundColor = UIColor.white
        self.addSubview(stackMain)
        
        NSLayoutConstraint.activate([
            stackMain.topAnchor.constraint(equalTo: self.topAnchor, constant: 16.0),
            stackMain.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            stackMain.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0),
            stackMain.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16.0)
        ])
        
        stackMain.addArrangedSubview(stackTitle)
        stackMain.addArrangedSubview(labelDescription)
        stackMain.addArrangedSubview(labelFooter)
        
        stackTitle.addArrangedSubview(labelTitle)
        stackTitle.addArrangedSubview(viewTag)
        
        viewTag.addSubview(labelTagTitle)
        
        NSLayoutConstraint.activate([
            labelTagTitle.centerXAnchor.constraint(equalTo: viewTag.centerXAnchor),
            labelTagTitle.centerYAnchor.constraint(equalTo: viewTag.centerYAnchor),
        ])
            
        NSLayoutConstraint.activate([
            viewTag.widthAnchor.constraint(equalToConstant: 40.0)
        ])
        
        NSLayoutConstraint.activate([
            stackTitle.heightAnchor.constraint(equalToConstant: 20.0),
            labelFooter.heightAnchor.constraint(equalToConstant: 12.0)
        ])
    }
    
    func setData(_ data: InstrumentationCellData) {
        self.viewTag.isHidden = true
        
        self.labelTitle.text = data.eventName
        self.labelDescription.text = data.attributes
        self.labelFooter.text = data.timestamp.toFormattedDate()
    }
    
}
