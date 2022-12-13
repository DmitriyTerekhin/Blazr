//
//  SettingsTableViewCell.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import UIKit

class SettingsTableViewCell: UITableViewCell, ReusableView {
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.setFont(fontName: .robotoRegular, sizeXS: 20)
        return lbl
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.titleLabel.textColor = .white.withAlphaComponent(0.5)
        },
                       completion:{ _ in
            UIView.animate(withDuration: 0.3,
                           animations: {
                self.titleLabel.textColor = .white.withAlphaComponent(1)
            })
        })
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .clear
        contentView.addSubview(titleLabel)
        titleLabel.centerYAnchor.constraint(equalTo: titleLabel.superview!.centerYAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleLabel.superview!.leftAnchor, constant: 52).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: -52).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
}
