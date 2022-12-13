//
//  CreatingDiceQuestionView.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 09.12.2022.
//

import UIKit

class CreatingDiceQuestionView: UIView {
    
    private enum Constatns {
        static let addTitle: String = "Add"
        static let yesTitle: String = "Yes\nFrom 1 to 2"
        static let from12: String = "From 1 to 2"
        static let noTitle: String = "No\nFrom 4 to 5"
        static let from45: String = "From 4 to 5"
        static let cornerRadius: CGFloat = 5
    }
        
    let addButton: GradientButtonView = {
        let btn = GradientButtonView(type: .system)
        btn.setTitle(Constatns.addTitle, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(font: .robotoBold, size: 12)
        btn.layer.masksToBounds = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = Constatns.cornerRadius
        btn.addTarget(nil, action: #selector(CreatingDiceViewController.addQuestionTapped), for: .touchUpInside)
        return btn
    }()
    
    let yesButton: GradientButtonView = {
        let btn = GradientButtonView()
        btn.setTitle(Constatns.yesTitle, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(font: .robotoRegular, size: 12)
        btn.titleLabel?.highlight(text: Constatns.from12, font: UIFont(font: .robotoBold, size: 12))
        btn.layer.masksToBounds = true
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = Constatns.cornerRadius
        return btn
    }()
    
    let noButton: GradientButtonView = {
        let btn = GradientButtonView()
        btn.setTitle(Constatns.noTitle, for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(font: .robotoRegular, size: 12)
        btn.titleLabel?.highlight(text: Constatns.from45, font: UIFont(font: .robotoBold, size: 12))
        btn.layer.masksToBounds = true
        btn.titleLabel?.numberOfLines = 0
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = Constatns.cornerRadius
        return btn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor(netHex: 0x1A242D)
        layer.cornerRadius = Constatns.cornerRadius
        addSubview(addButton)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: addButton.superview!.topAnchor, constant: 24),
            addButton.leftAnchor.constraint(equalTo: addButton.superview!.leftAnchor, constant: 20),
            addButton.rightAnchor.constraint(equalTo: addButton.superview!.rightAnchor, constant: -20),
            addButton.heightAnchor.constraint(equalToConstant: CGFloat(32).dp)
        ])
        
        addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yesButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 7),
            yesButton.leftAnchor.constraint(equalTo: yesButton.superview!.leftAnchor, constant: 20),
            yesButton.rightAnchor.constraint(equalTo: yesButton.superview!.centerXAnchor, constant: -7.5),
            yesButton.bottomAnchor.constraint(equalTo: yesButton.superview!.bottomAnchor, constant: -24)
        ])
        
        addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noButton.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 7),
            noButton.leftAnchor.constraint(equalTo: noButton.superview!.centerXAnchor, constant: 7.5),
            noButton.rightAnchor.constraint(equalTo: noButton.superview!.rightAnchor, constant: -20),
            noButton.bottomAnchor.constraint(equalTo: noButton.superview!.bottomAnchor, constant: -24)
        ])
    }
    
}
