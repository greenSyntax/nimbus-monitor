//
//  NetworkLogViewController.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import UIKit

protocol NetworkLogsDelegate: AnyObject {
    func didSelectedNetworkLog(_ data: NetworkCellData)
}

class NetworkLogsViewController: UIViewController {
    
    var viewModel : NetworkViewModel!
    weak var delegate: NetworkLogsDelegate?
    
    private var dataSource: [NetworkCellData] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.white
        table.separatorInset = .zero
        table.delegate = self
        table.dataSource = self
        table.register(NetworkCellView.self, forCellReuseIdentifier: NetworkCellView.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadData()
    }
    
    func prepareUI() {
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    func loadData() {
        viewModel.getData { result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let models):
                let cellData = models.map({ $0.toCellData() })
                self.updateData(cellData)
            }
        }
    }
    
    private func updateData(_ data: [NetworkCellData]) {
        self.dataSource.removeAll()
        self.dataSource = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    deinit {
        print("❌ Deinit for NetworkLogsViewController")
    }
    
}


extension NetworkLogsViewController: UITableViewDataSource, UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NetworkCellView.identifier) as! NetworkCellView
        cell.setData(dataSource[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectedNetworkLog(dataSource[indexPath.row])
    }
}
