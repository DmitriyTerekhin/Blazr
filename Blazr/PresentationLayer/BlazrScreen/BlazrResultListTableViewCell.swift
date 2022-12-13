//
//  BlazrResultListTableViewCell.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 10.12.2022.
//

import UIKit

class BlazrResultListTableViewCell: UITableViewCell, ReusableView {
    
    private let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(netHex: 0x7B8792)
        lbl.setFont(fontName: .robotoRegular, sizeXS: 12)
        return lbl
    }()
    
    private let questionLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor.white
        lbl.setFont(fontName: .robotoBold, sizeXS: 12)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let yesNoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(netHex: 0x1A242D)
        view.layer.cornerRadius = 5
        return view
    }()
    
    private let yesButton: GradientButtonView = {
        let btn = GradientButtonView()
        btn.setTitle("Yes", for: .normal)
        btn.alpha = 0
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(font: .robotoRegular, size: 12)
        btn.layer.masksToBounds = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 6
        return btn
    }()
    
    private let noButton: GradientButtonView = {
        let btn = GradientButtonView()
        btn.alpha = 0
        btn.setTitle("No", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont(font: .robotoRegular, size: 12)
        btn.layer.masksToBounds = true
        btn.titleLabel?.textAlignment = .center
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    var blazrResult: BlazrResult? {
        didSet {
            guard let result = blazrResult else { return }
            dateLabel.text = result.time.toString()
            questionLabel.text = result.question
            prepareGradients()
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        guard
            !yesButton.frame.isEmpty,
            !noButton.frame.isEmpty
        else { return }
        prepareGradients()
    }
    
    private func prepareGradients() {
        switch blazrResult?.diceResult {
        case .yes:
            addGreenGradient()
            addGrayToNo()
        case .no:
            applyGrayToYesGradients()
            addRedGradient()
        case .dontKnow:
            applyGrayToYesGradients()
            addGrayToNo()
        case .none:
            break
        }
        guard !yesButton.frame.isEmpty && !noButton.frame.isEmpty else { return }
        UIView.animate(withDuration: 0.2) {
            self.yesButton.alpha = 1
            self.noButton.alpha = 1
        }
    }
    
    private func applyGrayToYesGradients() {
        yesButton.layerGradient(startPoint: .bottomRight,
                                endPoint: .topLeft,
                                colorArray: [UIColor(netHex: 0x293642).cgColor,
                                             UIColor(netHex: 0x364350).cgColor],
                                type: .axial)
    }
    
    private func addGrayToNo() {
        noButton.layerGradient(startPoint: .bottomRight,
                               endPoint: .topLeft,
                               colorArray: [UIColor(netHex: 0x293642).cgColor,
                                            UIColor(netHex: 0x364350).cgColor],
                               type: .axial)
    }
    
    private func addRedGradient() {
        noButton.layerGradient(startPoint: .bottomRight,
                               endPoint: .topLeft,
                               colorArray: [UIColor(netHex: 0x9B172C).cgColor,
                                            UIColor(netHex: 0xF12C4C).cgColor],
                               type: .axial)
    }
    
    private func addGreenGradient() {
        yesButton.layerGradient(startPoint: .bottomRight,
                                endPoint: .topLeft,
                                colorArray: [UIColor(netHex: 0x179B6C).cgColor,
                                             UIColor(netHex: 0x5FF12C).cgColor],
                                type: .axial)
    }
    
    private func setupView() {
        backgroundColor = .clear
        
        contentView.addSubview(dateLabel)
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: dateLabel.superview!.topAnchor, constant: 16),
            dateLabel.leftAnchor.constraint(equalTo: dateLabel.superview!.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: dateLabel.superview!.rightAnchor)
        ])
        
        contentView.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor),
            questionLabel.leftAnchor.constraint(equalTo: questionLabel.superview!.leftAnchor),
            questionLabel.rightAnchor.constraint(equalTo: questionLabel.superview!.rightAnchor)
        ])
        
        contentView.addSubview(yesNoBackgroundView)
        let viewSize = resized(size: CGSize(width: 271, height: 67), basedOn: .height)
        yesNoBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yesNoBackgroundView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 7),
//            yesNoBackgroundView.leftAnchor.constraint(equalTo: yesNoBackgroundView.superview!.leftAnchor),
//            yesNoBackgroundView.rightAnchor.constraint(equalTo: yesNoBackgroundView.superview!.rightAnchor),
            yesNoBackgroundView.centerXAnchor.constraint(equalTo: yesNoBackgroundView.superview!.centerXAnchor),
            yesNoBackgroundView.heightAnchor.constraint(equalToConstant: viewSize.height),
            yesNoBackgroundView.widthAnchor.constraint(equalToConstant: viewSize.width),
            yesNoBackgroundView.bottomAnchor.constraint(equalTo: yesNoBackgroundView.superview!.bottomAnchor)
        ])
        
        yesNoBackgroundView.addSubview(yesButton)
        yesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            yesButton.topAnchor.constraint(equalTo: yesButton.superview!.topAnchor, constant: 15),
            yesButton.leftAnchor.constraint(equalTo: yesButton.superview!.leftAnchor, constant: 20),
            yesButton.rightAnchor.constraint(equalTo: yesButton.superview!.centerXAnchor, constant: -7.5),
            yesButton.bottomAnchor.constraint(equalTo: yesButton.superview!.bottomAnchor, constant: -15)
        ])
        
        yesNoBackgroundView.addSubview(noButton)
        noButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            noButton.topAnchor.constraint(equalTo: noButton.superview!.topAnchor, constant: 15),
            noButton.leftAnchor.constraint(equalTo: noButton.superview!.centerXAnchor, constant: 7.5),
            noButton.rightAnchor.constraint(equalTo: noButton.superview!.rightAnchor, constant: -20),
            noButton.bottomAnchor.constraint(equalTo: noButton.superview!.bottomAnchor, constant: -15)
        ])
    }
}

private extension Date {
    
    func toString(_ withFormat: String = "dd.MM.yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = withFormat
        return dateFormatter.string(from: self)
    }
    
}
