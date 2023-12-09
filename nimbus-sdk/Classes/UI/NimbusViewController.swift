//
//  NimbusViewController.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import UIKit

public class NimbusViewController: UIViewController {
    
    var service: NimbussService!
    
    private lazy var viewNavigation: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appBlackOff
        return view
    }()
    
    private lazy var stackTitle: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.axis = .horizontal
        return stack
    }()
    
    private lazy var buttonReload: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "img_reload", in: Bundle(for: NimbussService.self), compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(didReloadAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonDelete: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "img_delete", in: Bundle(for: NimbussService.self), compatibleWith: nil), for: .normal)
        button.addTarget(self, action: #selector(didDeleteAllAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var viewCategory: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.appBlackOff
        return view
    }()
    
    private lazy var componentCategory: UIView = {
        let category = CategoryView()
        category.delegate = self
        category.setCategory(.networkLogs)
        category.translatesAutoresizingMaskIntoConstraints = false
        return category
    }()
    
    private lazy var labelBrand: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont(name: "Avenir-Black", size: 18.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = SDKConstant.appName
        return label
    }()
    
    private lazy var viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var debugViewController: DebugLogsViewController = {
        let vc = DebugLogBuilder.build()
        vc.delegate = self
        vc.view.tag = 101
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    private lazy var networkLogsViewController: NetworkLogsViewController = {
        let vc = NetworkLogBuilder.build()
        vc.delegate = self
        vc.view.tag = 102
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    private lazy var instrumentationViewController: InstrumentationViewController = {
        let vc = InstrumentationLogBuilder.build()
        vc.delegate = self
        vc.view.tag = 103
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        return vc
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        self.becomeFirstResponder()
        prepareUI()
    }
    
    func prepareUI() {
        self.view.addSubview(viewNavigation)
        
        NSLayoutConstraint.activate([
            self.viewNavigation.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.viewNavigation.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.viewNavigation.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.viewNavigation.heightAnchor.constraint(equalToConstant: 90.0)
        ])
        
        self.viewNavigation.addSubview(stackTitle)
        
        NSLayoutConstraint.activate([
            self.stackTitle.topAnchor.constraint(equalTo: viewNavigation.topAnchor, constant: 8.0),
            self.stackTitle.leadingAnchor.constraint(equalTo: viewNavigation.leadingAnchor, constant: 8.0),
            self.stackTitle.trailingAnchor.constraint(equalTo: viewNavigation.trailingAnchor, constant: -8.0),
            self.stackTitle.bottomAnchor.constraint(equalTo: viewNavigation.bottomAnchor, constant: 8.0),
        ])
        
        stackTitle.addArrangedSubview(buttonReload)
        stackTitle.addArrangedSubview(labelBrand)
        stackTitle.addArrangedSubview(buttonDelete)
        
        NSLayoutConstraint.activate([
            self.buttonReload.widthAnchor.constraint(equalToConstant: 45),
            self.buttonDelete.widthAnchor.constraint(equalToConstant: 45),
        ])
        
        self.view.addSubview(viewCategory)
        
        NSLayoutConstraint.activate([
            self.viewCategory.topAnchor.constraint(equalTo: self.viewNavigation.bottomAnchor),
            self.viewCategory.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.viewCategory.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.viewCategory.heightAnchor.constraint(equalToConstant: 60.0)
        ])
        
        viewCategory.addSubview(componentCategory)
        
        NSLayoutConstraint.activate([
            componentCategory.topAnchor.constraint(equalTo: viewCategory.topAnchor),
            componentCategory.leadingAnchor.constraint(equalTo: viewCategory.leadingAnchor),
            componentCategory.trailingAnchor.constraint(equalTo: viewCategory.trailingAnchor),
            componentCategory.bottomAnchor.constraint(equalTo: viewCategory.bottomAnchor),
        ])
        
        self.view.addSubview(viewContainer)
        
        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: self.viewCategory.bottomAnchor),
            viewContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            viewContainer.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    @objc private func didReloadAction() {
        
        //TODO: Get Active Index
        self.debugViewController.loadData()
        print("Reload Data for Debug Logs ...")
    }
    
    @objc private func didDeleteAllAction() {
        let actionSheet = UIAlertController(title: "Delete Data", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Delete All Debug Logs", style: .default, handler: { _ in
            self.service.deleteDebugLogs()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.debugViewController.loadData()
            })
        }))
        actionSheet.addAction(UIAlertAction(title: "Delete All Network Traffic", style: .default, handler: { _ in
            self.service.deleteNetworkLogs()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.networkLogsViewController.loadData()
            })
            
        }))
        actionSheet.addAction(UIAlertAction(title: "Delete All Instrumentation", style: .default, handler: { _ in
            self.service.deleteInstrumentationLogs()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                self.instrumentationViewController.loadData()
            })
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
    }
    
    deinit {
        print("❌ Deinit NimbusVC")
    }
    
}

extension NimbusViewController: CategoryViewDelegate {
    
    func updateConstrint(_ view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            view.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
        ])
    }
    
    func didSelectDebugLogs() {
        let debugViewExist = self.viewContainer.subviews.filter({ $0.tag == 101 })
        
        if debugViewExist.first == nil {
            self.viewContainer.addSubview(self.debugViewController.view)
            self.updateConstrint(self.debugViewController.view)
        } else {
            self.viewContainer.bringSubviewToFront(debugViewExist.first!)
        }
    }
    
    func didSelectNetworkLogs() {
        let networkViewExist = self.viewContainer.subviews.filter({ $0.tag == 102 })
        
        if networkViewExist.first == nil {
            self.viewContainer.addSubview(self.networkLogsViewController.view)
            self.updateConstrint(self.networkLogsViewController.view)
        } else {
            self.viewContainer.bringSubviewToFront(networkViewExist.first!)
        }
    }
    
    func didSelectInstrumentation() {
        let instrumentationViewExist = self.viewContainer.subviews.filter({ $0.tag == 103 })
        
        if instrumentationViewExist.first == nil {
            self.viewContainer.addSubview(self.instrumentationViewController.view)
            self.updateConstrint(self.instrumentationViewController.view)
        } else {
            self.viewContainer.bringSubviewToFront(instrumentationViewExist.first!)
        }
    }
    
}

extension NimbusViewController: DebugLogsDelegate, NetworkLogsDelegate, InstrumentationLogsDelegate {
    
    func didSelectedDebugLog(_ log: LogViewCellData) {
        let vc = DetailViewController()
        vc.setDataSource(log.transformToDetailModel())
        self.present(vc, animated: true)
    }
    
    func didSelectedNetworkLog(_ data: NetworkCellData) {
        let vc = DetailViewController()
        vc.setDataSource(data.transformToDetailModel())
        self.present(vc, animated: true)
    }
    
    func didSelectedInstrumentationLog(_ data: InstrumentationCellData) {
        let vc = DetailViewController()
        vc.setDataSource(data.transformToDetailModel())
        self.present(vc, animated: true)
    }
}
