//
//  BlazrView.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import UIKit

class BlazrView: UIView {
    
    private enum Constants {
        static let noBlazr: String = "There are\nno Blazrs yet ;("
    }
    
    let bowlImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "Bowl"))
        iv.isHidden = true
        return iv
    }()
    
    let statusTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.text = Constants.noBlazr
        lbl.setFont(fontName: .RobotoMedium, sizeXS: 20)
        lbl.textAlignment = .center
        lbl.numberOfLines = 2
        lbl.isHidden = true
        return lbl
    }()
    
    let table: UITableView = {
        let tbl = UITableView()
        tbl.isHidden = true
        tbl.setContentOffset(CGPoint(x: 0, y: 73), animated: false)
        tbl.backgroundColor = .clear
        tbl.contentInset.bottom = 200
        tbl.showsVerticalScrollIndicator = false
        tbl.register(BlazrResultListTableViewCell.self, forCellReuseIdentifier: BlazrResultListTableViewCell.reuseID)
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
        
        addSubview(bowlImageView)
        bowlImageView.centerXAnchor.constraint(equalTo: bowlImageView.superview!.centerXAnchor).isActive = true
        bowlImageView.centerYAnchor.constraint(equalTo: bowlImageView.superview!.centerYAnchor, constant: -50).isActive = true
        bowlImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(statusTitleLabel)
        statusTitleLabel.centerXAnchor.constraint(equalTo: statusTitleLabel.superview!.centerXAnchor).isActive = true
        statusTitleLabel.topAnchor.constraint(equalTo: bowlImageView.bottomAnchor, constant: 41).isActive = true
        statusTitleLabel.widthAnchor.constraint(equalToConstant: 271).isActive = true
        statusTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(table)
        let viewSize = resized(size: CGSize(width: 271, height: 67), basedOn: .height)
        table.translatesAutoresizingMaskIntoConstraints = false
//        table.leftAnchor.constraint(equalTo: table.superview!.leftAnchor, constant: viewSize.).isActive = true
//        table.rightAnchor.constraint(equalTo: table.superview!.rightAnchor, constant: -size).isActive = true
        table.widthAnchor.constraint(equalToConstant: viewSize.width).isActive = true
        table.centerXAnchor.constraint(equalTo: table.superview!.centerXAnchor).isActive = true
        table.topAnchor.constraint(equalTo: table.superview!.safeTopAnchor, constant: 0).isActive = true
        table.bottomAnchor.constraint(equalTo: table.superview!.safeBottomAnchor, constant: 0).isActive = true
    }

}
