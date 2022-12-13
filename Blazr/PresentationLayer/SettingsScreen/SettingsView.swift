//
//  SettingsView.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import UIKit

class SettingsView: UIView {
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "SettingLogoFire")
        return iv
    }()
    
    let tableView: UITableView = {
        let tbl = UITableView()
        tbl.showsVerticalScrollIndicator = false
        tbl.rowHeight = UIScreen.current.rawValue > 2 ? CGFloat(44).dp : CGFloat(34).dp
        tbl.separatorStyle = .none
        tbl.backgroundColor = .clear
        tbl.contentInset.top = 100
        tbl.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseID)
        return tbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .AppCollors.background
        addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.rightAnchor.constraint(equalTo: logoImageView.superview!.rightAnchor),
            logoImageView.topAnchor.constraint(equalTo: logoImageView.superview!.topAnchor),
        ])
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.rightAnchor.constraint(equalTo: tableView.superview!.rightAnchor),
            tableView.topAnchor.constraint(equalTo: tableView.superview!.centerYAnchor, constant: -100),
            tableView.leftAnchor.constraint(equalTo: tableView.superview!.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: tableView.superview!.bottomAnchor)
        ])
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
}
