//
//  CategoryView.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import UIKit

enum Category {
    case debugLogs
    case networkLogs
    case instrumentation
}

protocol CategoryViewDelegate: AnyObject {
    func didSelectDebugLogs()
    func didSelectNetworkLogs()
    func didSelectInstrumentation()
}

class CategoryView: UIView {
    
    var activeCategory: Category = .debugLogs
    
    weak var delegate: CategoryViewDelegate?
    
    private lazy var stackMain: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.spacing = 6.0
        stack.axis = .horizontal
        return stack
    }()

    private lazy var buttonLog: NBButton = {
        let button = NBButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14.0)
        button.setTitle("Debug Logs", for: .normal)
        button.addTarget(self, action: #selector(CategoryView.didSelectDebugLogs), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonNetworkTraffic: NBButton = {
        let button = NBButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14.0)
        button.setTitle("Network Logs", for: .normal)
        button.addTarget(self, action: #selector(CategoryView.didSelectNetworkLogs), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonInstrumentation: NBButton = {
        let button = NBButton()
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Medium", size: 14.0)
        button.setTitle("Instrumentation", for: .normal)
        button.addTarget(self, action: #selector(CategoryView.didSelectInstrumentation), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.buttonLog.round()
        self.buttonNetworkTraffic.round()
        self.buttonInstrumentation.round()
    }
    
    func initialize() {
        self.backgroundColor = UIColor.clear
        self.addSubview(stackMain)
        
        NSLayoutConstraint.activate([
            self.stackMain.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.stackMain.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.stackMain.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.stackMain.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
        ])
        
        stackMain.addArrangedSubview(buttonNetworkTraffic)
        stackMain.addArrangedSubview(buttonInstrumentation)
        stackMain.addArrangedSubview(buttonLog)
    }
    
    func setCategory(_ category: Category) {
        self.activeCategory = category
        updateCategorySelectionState(category)
        
        switch category {
        case .debugLogs:
            delegate?.didSelectDebugLogs()
        case .instrumentation:
            delegate?.didSelectInstrumentation()
        case .networkLogs:
            delegate?.didSelectNetworkLogs()
        }
    }
    
    private func updateCategorySelectionState(_ category: Category) {
        switch category {
        case .debugLogs:
            buttonLog.selectionState = .active
            buttonInstrumentation.selectionState = .inactive
            buttonNetworkTraffic.selectionState = .inactive
        case .instrumentation:
            buttonLog.selectionState = .inactive
            buttonInstrumentation.selectionState = .active
            buttonNetworkTraffic.selectionState = .inactive
        case .networkLogs:
            buttonLog.selectionState = .inactive
            buttonInstrumentation.selectionState = .inactive
            buttonNetworkTraffic.selectionState = .active
        }
    }
    
    @objc private func didSelectDebugLogs() {
        updateCategorySelectionState(.debugLogs)
        delegate?.didSelectDebugLogs()
    }
    
    @objc private func didSelectNetworkLogs() {
        updateCategorySelectionState(.networkLogs)
        delegate?.didSelectNetworkLogs()
    }
    
    @objc private func didSelectInstrumentation() {
        updateCategorySelectionState(.instrumentation)
        delegate?.didSelectInstrumentation()
    }
}
