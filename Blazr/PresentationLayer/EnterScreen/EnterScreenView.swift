//
//  EnterScreenView.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import UIKit

class EnterView: UIView {
    
    private enum Constants {
        static let title: String = "nacional"
        static let subtitle: String = "Find sports near you"
        static let appleSignIn: String = "Sign In with Apple"
        static let termsAndConditions: String = "Please, read our\n\(Constants.terms) and \(Constants.privacy)"
        static let cornerRadius: CGFloat = 5
        static let terms: String = "Terms and Conditions"
        static let privacy: String = "Privacy Policy"
        static let firsLabelText: String = "Let's get to know each other.\nMy name is Blazr."
        static let highlightText: String = "My name is Blazr"
        static let secondLabelText: String = "And I’m here to help you to make difficult choices"
    }
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "FireSmile")
        return iv
    }()
    
    private let termsAndPolicyTextView: UITextView = {
        let txtV = UITextView()
        txtV.textColor = .white
        txtV.text = Constants.termsAndConditions
        txtV.backgroundColor = .clear
        return txtV
    }()
    
    private let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.setFont(fontName: .robotoRegular, sizeXS: 20)
        lbl.textColor = .white
        lbl.text = Constants.firsLabelText
        lbl.highlight(text: Constants.highlightText, font: UIFont(font: .robotoBold, size: 20), color: .white)
        return lbl
    }()
    
    private let subtitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
        lbl.setFont(fontName: .robotoRegular, sizeXS: 20)
        lbl.textColor = UIColor(netHex: 0x7B8792)
        lbl.text = Constants.secondLabelText
        return lbl
    }()
    
    private let signInButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(Constants.appleSignIn, for: .normal)
        btn.setImage(UIImage(named: "AppleIcon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .white
        btn.titleLabel!.setFont(fontName: .robotoRegular, sizeXS: 18)
        if #available(iOS 15, *) {
            var config = UIButton.Configuration.plain()
            config.imagePadding = 10
            config.background.backgroundColor = UIColor.AppCollors.red
            config.background.cornerRadius = Constants.cornerRadius
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(font: .robotoRegular, size: 18)
                return outgoing
            }
            btn.configuration = config
        } else {
            btn.imageEdgeInsets.right = 5
            btn.backgroundColor = .AppCollors.red
        }
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    var signInHandler: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        prepareAttributesForTextView()
        setupView()
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    private func signInTapped() {
        signInHandler?()
    }
    
    private func setupView() {
        backgroundColor = .AppCollors.background
        
        let leftRightDistance = adapted(dimensionSize: 52, to: .height)
        
        addSubview(titleLabel)
        let titleTop = adapted(dimensionSize: 147, to: .height)
        titleLabel.topAnchor.constraint(equalTo: titleLabel.superview!.topAnchor, constant: titleTop).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: titleLabel.superview!.centerXAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: titleLabel.superview!.leftAnchor, constant: leftRightDistance).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: titleLabel.superview!.rightAnchor, constant: -leftRightDistance).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleLabel.centerXAnchor.constraint(equalTo: subtitleLabel.superview!.centerXAnchor).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: subtitleLabel.superview!.leftAnchor, constant: leftRightDistance).isActive = true
        subtitleLabel.rightAnchor.constraint(equalTo: subtitleLabel.superview!.rightAnchor, constant: -leftRightDistance).isActive = true
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(logoImageView)
        let logoSize = resized(size: CGSize(width: 135, height: 180), basedOn: .height)
        logoImageView.centerXAnchor.constraint(equalTo: logoImageView.superview!.centerXAnchor).isActive = true
        logoImageView.centerYAnchor.constraint(equalTo: logoImageView.superview!.centerYAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: logoSize.width).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: logoSize.height).isActive = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(termsAndPolicyTextView)
        let termsBottom = adapted(dimensionSize: 68, to: .height)
        termsAndPolicyTextView.centerXAnchor.constraint(equalTo: termsAndPolicyTextView.superview!.centerXAnchor, constant: 0).isActive = true
        termsAndPolicyTextView.bottomAnchor.constraint(equalTo: termsAndPolicyTextView.superview!.bottomAnchor, constant: -termsBottom).isActive = true
        termsAndPolicyTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        termsAndPolicyTextView.leftAnchor.constraint(equalTo: termsAndPolicyTextView.superview!.leftAnchor, constant: leftRightDistance).isActive = true
        termsAndPolicyTextView.rightAnchor.constraint(equalTo: termsAndPolicyTextView.superview!.rightAnchor, constant: -leftRightDistance).isActive = true
        termsAndPolicyTextView.translatesAutoresizingMaskIntoConstraints = false
        
        let signButtonSize = resized(size: CGSize(width: 271, height: 60), basedOn: .height)
        addSubview(signInButton)
        signInButton.centerXAnchor.constraint(equalTo: signInButton.superview!.centerXAnchor).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: signButtonSize.height).isActive = true
        signInButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 64).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: signButtonSize.width).isActive = true
        signInButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func prepareAttributesForTextView() {
        let text = (termsAndPolicyTextView.text ?? "") as NSString
        termsAndPolicyTextView.font = UIFont(font: .robotoRegular, size: 12)
        let attributedString = termsAndPolicyTextView.addHyperLinksToText(
            originalText: text as String, hyperLinks: [
                Constants.privacy: "https://get-nacional.space/privacy.html",
                Constants.terms: "https://get-nacional.space/terms.html"
            ],
            font:  UIFont(font: .robotoRegular, size: 12)
        )
        let linkAttributes: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        termsAndPolicyTextView.linkTextAttributes = linkAttributes
        termsAndPolicyTextView.textColor = .white
        termsAndPolicyTextView.textAlignment = .center
        termsAndPolicyTextView.isUserInteractionEnabled = true
        termsAndPolicyTextView.isEditable = false
        termsAndPolicyTextView.attributedText = attributedString
    }
    
}

private extension UITextView {
    func addHyperLinksToText(originalText: String, hyperLinks: [String: String], font: UIFont, textAlignment: NSTextAlignment = .center) -> NSMutableAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = textAlignment
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        let fullRange = NSRange(location: 0, length: attributedOriginalText.length)
        for (hyperLink, urlString) in hyperLinks {
            let linkRange = attributedOriginalText.mutableString.range(of: hyperLink)
            attributedOriginalText.addAttribute(NSAttributedString.Key.link, value: urlString, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: fullRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: linkRange)
            attributedOriginalText.addAttribute(NSAttributedString.Key.font, value: font, range: fullRange)
        }
        attributedOriginalText.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: fullRange)
        return attributedOriginalText
    }
}
