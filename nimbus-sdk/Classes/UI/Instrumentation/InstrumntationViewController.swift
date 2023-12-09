//
//  InstrumntationViewController.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import UIKit

protocol InstrumentationLogsDelegate: AnyObject {
    func didSelectedInstrumentationLog(_ data: InstrumentationCellData)
}

class InstrumentationViewController: UIViewController {
    
    var viewModel: InstrumentationViewModel!
    var dataSource: [InstrumentationCellData] = []
    
    weak var delegate: InstrumentationLogsDelegate?
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.backgroundColor = UIColor.white
        table.separatorInset = .zero
        table.delegate = self
        table.dataSource = self
        table.register(InstrumentationViewCell.self, forCellReuseIdentifier: InstrumentationViewCell.identifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI()
        loadData()
    }

    deinit {
        print("❌ Deinit for InstrumentationViewController")
    }
    
    func prepareUI() {
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
    
    private func updateData(_ data: [InstrumentationCellData]) {
        self.dataSource.removeAll()
        self.dataSource = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}

extension InstrumentationViewController: UITableViewDataSource, UITableViewDelegate {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: InstrumentationViewCell.identifier) as! InstrumentationViewCell
                cell.setData(dataSource[indexPath.row])
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didSelectedInstrumentationLog(dataSource[indexPath.row])
    }
}

