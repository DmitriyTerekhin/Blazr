//
//  LaunchScreenView.swift
//  Nacional
//
//  Created by Дмитрий Терехин on 29.11.2022.
//

import UIKit

class LaunchScreenView: UIView {
    
    private let blazrImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "BlazrLogo")
        return iv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .AppCollors.background
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(blazrImageView)
        blazrImageView.centerYAnchor.constraint(equalTo: blazrImageView.superview!.centerYAnchor, constant: 0).isActive = true
        blazrImageView.centerXAnchor.constraint(equalTo: blazrImageView.superview!.centerXAnchor).isActive = true
        blazrImageView.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
