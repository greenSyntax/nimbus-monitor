//
//  DetailViewController.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 06/09/23.
//

import UIKit

struct DetailCellData {
    var type: String
    var title: String
    var data: String
}

class DetailViewController: UIViewController {
    
    private lazy var viewNavigation: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appBlackOff
        return view
    }()
    
    private lazy var stackMain: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonRight: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "img_share", in: Bundle(for: NimbussService.self), compatibleWith: nil), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 2, left: 8, bottom: 2, right: 8)
        button.addTarget(self, action: #selector(buttonRightSelected), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonLeft: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "img_back", in: Bundle(for: NimbussService.self), compatibleWith: nil), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        button.addTarget(self, action: #selector(buttonLeftSelected), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelBrand: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Black", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Detail Data"
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.white
        table.separatorInset = .zero
        table.allowsSelection = false
        table.delegate = self
        table.dataSource = self
        table.register(DetailTextCell.self, forCellReuseIdentifier: DetailTextCell.identifier)
        return table
    }()
    
    lazy var dataSource: [DetailCellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        tableUI()
    }
    
    func setDataSource(_ data: [DetailCellData]) {
        self.dataSource = data
    }
    
    func prepareUI() {
        //TODO:
        self.buttonRight.isHidden = false
        self.buttonLeft.isHidden = false
        
        self.view.backgroundColor = UIColor.blue
        
        self.view.addSubview(viewNavigation)
        
        NSLayoutConstraint.activate([
            self.viewNavigation.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.viewNavigation.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.viewNavigation.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.viewNavigation.heightAnchor.constraint(equalToConstant: 80.0)
        ])
        
        self.viewNavigation.addSubview(stackMain)
        
        NSLayoutConstraint.activate([
            self.stackMain.topAnchor.constraint(equalTo: self.viewNavigation.topAnchor),
            self.stackMain.leadingAnchor.constraint(equalTo: self.viewNavigation.leadingAnchor, constant: 8.0),
            self.stackMain.trailingAnchor.constraint(equalTo: self.viewNavigation.trailingAnchor, constant: -8.0),
            self.stackMain.bottomAnchor.constraint(equalTo: self.viewNavigation.bottomAnchor)
        ])
        
        self.stackMain.addArrangedSubview(buttonLeft)
        self.stackMain.addArrangedSubview(labelBrand)
        self.stackMain.addArrangedSubview(buttonRight)
        
        NSLayoutConstraint.activate([
            self.buttonLeft.widthAnchor.constraint(equalToConstant: 45),
            self.buttonRight.widthAnchor.constraint(equalToConstant: 45),
        ])
    }
    
    func tableUI() {
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.viewNavigation.bottomAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    @objc private func buttonLeftSelected() {
        self.dismiss(animated: true)
    }
    
    @objc private func buttonRightSelected() {
        print("Share Data: ")
    }
    
}

extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTextCell.identifier) as! DetailTextCell
        cell.setData(dataSource[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //TODO:
    }
    
}
