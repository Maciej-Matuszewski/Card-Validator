//
//  MMButton.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

/// Custom button with defin style, inherit from __UIButton__
class MMButton: UIButton {
    
    /// Callback method executed on button touch up inside
    var onClickCallback: (()->Void)
    
    /// Value that inform that button currently is highlighted
    override var isHighlighted: Bool{
        didSet{
            UIView.animate(withDuration: 0.3) {[weak self] in
                self?.alpha = self?.isHighlighted ?? false ? 0.7 : 1.0
            }
        }
    }
    
    /// __MMButton__ constructor
    ///
    /// - Parameters:
    ///   - title: button title
    ///   - callback: callback method executed on button touch up inside
    init(title: String, callback: @escaping (()->Void)) {
        self.onClickCallback = callback
        super.init(frame: CGRect.zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.main
        self.setTitle(title, for: UIControlState.normal)
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.titleLabel?.font = UIFont.normalBold
        self.layer.cornerRadius = Constants.Values.CornerRadius
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.8).isActive = true
        self.addTarget(self, action: #selector(self.onClickFunction), for: UIControlEvents.touchUpInside)
    }
    
    /// method that is called on touch up inside, should execute callback
    @objc private func onClickFunction(){
        self.onClickCallback()
    }
    
    /// __UNSUPORTED__ __MMButton__ constructor _NSCoder_ parameter
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
