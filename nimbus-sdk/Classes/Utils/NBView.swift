//
//  NBView.swift
//  NimbusSDK
//
//  Created by Abhishek Ravi on 05/09/23.
//

import Foundation

extension UIView {
    
    func round() {
        self.layer.cornerRadius = 14.0
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layoutIfNeeded()
    }
    
}

enum NBButtonState {
    case active
    case inactive
}

class NBButton: UIButton {
    
    var selectionState: NBButtonState = .inactive {
        didSet {
            initialize()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        switch selectionState {
        case .active:
            self.layer.borderColor = UIColor.white.cgColor
            self.backgroundColor = UIColor.white
            self.setTitleColor(UIColor.appBlack, for: .normal)
        case .inactive:
            self.layer.borderColor = UIColor.gray.cgColor
            self.setTitleColor(UIColor.gray, for: .normal)
            self.backgroundColor = UIColor.clear
        }
    }
    
}
