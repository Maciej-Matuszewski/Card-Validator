//
//  MMStatusIndicator.swift
//  Netguru Interview App
//
//  Created by Maciej Matuszewski on 27.07.2017.
//  Copyright © 2017 Maciej Matuszewski. All rights reserved.
//

import UIKit

/// Indicator with four states
class MMStatusIndicator: UIView {

    /// States for MMStatusIndicator
    ///
    /// - loading: Animated UIActivityIndicatorView
    /// - hidden: Nothing
    /// - success: Green image with tick
    /// - failure: Red image with "x"
    enum State {
        case loading
        case hidden
        case success
        case failure
    }
    
    /// image view necessary for states _success_ and _failure_
    private let imageView = UIImageView.init()
    
    /// image view necessary for state _loading_
    private let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
    
    /// current state of indicator
    public var state: State = .hidden
    
    /// __MMStatusIndicator__ constructor
    init() {
        super.init(frame: CGRect.zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.layer.masksToBounds = true
        
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.imageView)
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.imageView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.imageView.contentMode = .center
        
        self.indicator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.indicator)
        self.indicator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.indicator.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.indicator.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.indicator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.indicator.color = UIColor.main
        self.indicator.hidesWhenStopped = true
        
        self.setState(.hidden)
    }
    
    /// Change state of MMStatusIndicator for current status
    ///
    /// - Parameter state: enum MMStatusIndicator.State
    public func setState(_ state: State){
        self.state = state
        switch state {
        case .loading:
            self.indicator.startAnimating()
            self.imageView.isHidden = true
            self.indicator.isHidden = false
            break
        case .hidden:
            self.indicator.stopAnimating()
            self.imageView.isHidden = true
            self.indicator.isHidden = true
            break
        case .success:
            self.indicator.stopAnimating()
            self.imageView.image = #imageLiteral(resourceName: "checked")
            self.imageView.isHidden = false
            self.indicator.isHidden = true
            break
        case .failure:
            self.indicator.stopAnimating()
            self.imageView.image = #imageLiteral(resourceName: "close")
            self.imageView.isHidden = false
            self.indicator.isHidden = true
            break
        }
    }
    
    /// __UNSUPORTED__ _MMStatusIndicator_ constructor _NSCoder_ parameter
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
