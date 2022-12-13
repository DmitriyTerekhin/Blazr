//
//  CreatingView.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import UIKit

class CreatingView: UIView {
    
    private enum Constants {
        static let newDiceTitle: String = "Start new Dice"
        static let nextTitle: String = "Next"
        static let saveTitle: String = "Save"
        static let weAreSetTitle: String = "We are set.\nNow add your question."
        static let weAreSetHiglitedText: String = "Now add your question."
        static let hereWeAre: String = "Here we are...\nType the question below."
        static let hereWeAreHighlited: String = "Type the question below."
        static let cornerRadius: CGFloat = 5
        static let letsDice = "Okay, let’s dice!"
        static let waitAseconds = "Wait a second..."
        
        static let privacyText: String = "I agree with Privacy policy of service"
        static let ok: String = "Okay"
        static let privacyClickableText: String = "Privacy policy"
        static let privacySite: String = "https://super-best.fun/privacy.html"
        static let termsAndConditionsText: String = "I agree with Terms and conditions of service"
        static let termsAndConditionsSite: String = "https://super-best.fun/terms.html"
        static let termsAndConditionsClickableText: String = "Terms and conditions"
        static let userGeneratedText: String = "I agree with user generated content rules of service"
        static let userGeneratedSite: String = "https://super-best.fun/content.html"
        static let userGeneratedClickableText: String = "user generated content rules"
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "Сubes")
        return iv
    }()
    
    private let backButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "Back"), for: .normal)
        btn.isHidden = true
        btn.addTarget(nil, action: #selector(CreatingDiceViewController.backButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let backButtonLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Back"
        lbl.textColor = .white
        lbl.setFont(fontName: .robotoBold, sizeXS: 12)
        lbl.isHidden = true
        return lbl
    }()
    
    private let stateTitleLabel: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .white
        lbl.setFont(fontName: .robotoRegular, sizeXS: 20)
        lbl.numberOfLines = 0
        lbl.isHidden = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let mainButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle(Constants.newDiceTitle, for: .normal)
        btn.tintColor = .white
        btn.titleLabel!.setFont(fontName: .RobotoMedium, sizeXS: 20)
        if #available(iOS 15, *) {
            var config = UIButton.Configuration.plain()
            config.imagePadding = 10
            config.background.backgroundColor = UIColor.AppCollors.red
            config.background.cornerRadius = Constants.cornerRadius
            config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont(font: .RobotoMedium, size: 20)
                return outgoing
            }
            btn.configuration = config
        } else {
            btn.imageEdgeInsets.right = 5
            btn.backgroundColor = .AppCollors.red
        }
        btn.layer.cornerRadius = Constants.cornerRadius
        btn.setTitleColor(.white, for: .normal)
        btn.addTarget(nil, action: #selector(CreatingDiceViewController.mainButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private let creatingDiceQuestionView: CreatingDiceQuestionView = {
        let view = CreatingDiceQuestionView()
        view.isHidden = true
        return view
    }()
    
    private let questionTextFieldBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(netHex: 0x1A242D)
        view.layer.cornerRadius = Constants.cornerRadius
        view.isHidden = true
        return view
    }()
    
    let questionTextField: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = UIColor(netHex: 0x0F1923)
        tf.layer.cornerRadius = Constants.cornerRadius
        tf.font = UIFont(font: .robotoBold, size: 12)
        tf.textColor = .white
        tf.tintColor = .white
        tf.setLeftPaddingPoints(7)
        tf.isHidden = true
        tf.addTarget(nil, action: #selector(CreatingDiceViewController.textFieldValueDidChanged), for: .editingChanged)
        return tf
    }()
    
    private let letsButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(UIImage(named: "Lets")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.setFont(fontName: .robotoRegular, sizeXS: 20)
        btn.isHidden = true
        btn.addTarget(nil, action: #selector(CreatingDiceViewController.letsDiceTapped), for: .touchUpInside)
        return btn
    }()
    
    private let clickButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Click", for: .normal)
        btn.titleLabel?.setFont(fontName: .robotoRegular, sizeXS: 20)
        btn.isHidden = true
        btn.addTarget(nil, action: #selector(CreatingDiceViewController.letsDiceTapped), for: .touchUpInside)
        return btn
    }()
    
    private let noteLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Note! The results of the answers are complete randomness. Please do not take them as advice for action. Remember that our application is entertaining."
        lbl.textColor = .white
        lbl.setFont(fontName: .robotoRegular, sizeXS: 10)
        lbl.highlight(text: "Note!", font: UIFont(font: .RobotoMedium, size: 12))
        lbl.numberOfLines = 0
        lbl.isHidden = true
        lbl.textAlignment = .center
        return lbl
    }()
    
    let privacyCheckBox: CheckBoxButtonView = {
        let cb = CheckBoxButtonView()
        cb.addText(text: Constants.privacyText as NSString,
                   wordsInText: Constants.privacyClickableText,
                   siteToGo: Constants.privacySite)
        cb.checkBoxButton.tag = 1
        cb.checkBoxButton.addTarget(nil, action: #selector(CreatingDiceViewController.checkBoxTapped), for: .touchUpInside)
        return cb
    }()
    
    let termsCheckBox: CheckBoxButtonView = {
        let cb = CheckBoxButtonView()
        cb.addText(text: Constants.termsAndConditionsText as NSString,
                   wordsInText: Constants.termsAndConditionsClickableText,
                   siteToGo: Constants.termsAndConditionsSite)
        cb.checkBoxButton.tag = 2
        cb.checkBoxButton.addTarget(nil, action: #selector(CreatingDiceViewController.checkBoxTapped), for: .touchUpInside)
        return cb
    }()
    
    let userGeneratedCheckBox: CheckBoxButtonView = {
        let cb = CheckBoxButtonView()
        cb.addText(text: Constants.userGeneratedText as NSString,
                   wordsInText: Constants.userGeneratedClickableText,
                   siteToGo: Constants.userGeneratedSite)
        cb.checkBoxButton.tag = 3
        cb.checkBoxButton.addTarget(nil, action: #selector(CreatingDiceViewController.checkBoxTapped), for: .touchUpInside)
        return cb
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.isHidden = true
        return sv
    }()
    
    private var stateTitleLabelTopAnchor = NSLayoutConstraint()
    private var stateTitleLabelBottomAnchor = NSLayoutConstraint()
    private var imageViewCenterYAnchor = NSLayoutConstraint()
    private var imageViewWidthAnchor = NSLayoutConstraint()
    private var imageViewHeightAnchor = NSLayoutConstraint()
    
    var isQuestionExist = false

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func applyGradients() {
        creatingDiceQuestionView.addButton.layerGradient(startPoint: .centerRight,
                                endPoint: .centerLeft,
                                colorArray: [UIColor(netHex: 0x293642).cgColor,
                                             UIColor(netHex: 0x364350).cgColor],
                                type: .axial)
        creatingDiceQuestionView.yesButton.layerGradient(startPoint: .bottomRight,
                                                         endPoint: .topLeft,
                                                         colorArray: [UIColor(netHex: 0x293642).cgColor,
                                                                      UIColor(netHex: 0x364350).cgColor],
                                                         type: .axial)
        creatingDiceQuestionView.noButton.layerGradient(startPoint: .bottomRight,
                                                         endPoint: .topLeft,
                                                         colorArray: [UIColor(netHex: 0x293642).cgColor,
                                                                      UIColor(netHex: 0x364350).cgColor],
                                                         type: .axial)
    }
    
    func prepareViewFor(state: CreatingDiceViewState) {
        switch state {
        case .initial:
            let imageViewSize = resized(size: CGSize(width: 250, height: 350), basedOn: .height)
            imageViewWidthAnchor.constant = imageViewSize.width
            imageViewHeightAnchor.constant = imageViewSize.height
            mainButton.setTitle(Constants.newDiceTitle, for: .normal)
            mainButton.isHidden = false
            imageView.isHidden = false
            imageView.image = UIImage(named: "Сubes")
            creatingDiceQuestionView.addButton.setTitle("Add", for: .normal)
            backButtonLabel.isHidden = true
            backButton.isHidden = true
            mainButton.backgroundColor = .AppCollors.red
            stateTitleLabel.isHidden = true
            creatingDiceQuestionView.isHidden = true
            mainButton.alpha = 1
            imageViewCenterYAnchor.constant = -70
            stateTitleLabelBottomAnchor.isActive = false
            stateTitleLabelTopAnchor.isActive = true
        case .startCreating:
            applyGradients()
            creatingDiceQuestionView.isHidden = false
            imageView.isHidden = true
            mainButton.setTitle(Constants.nextTitle, for: .normal)
            backButton.isHidden = false
            backButtonLabel.isHidden = false
            mainButton.alpha = 0.5
            stateTitleLabel.isHidden = false
            stateTitleLabel.text = Constants.weAreSetTitle
            stateTitleLabel.highlight(text: Constants.weAreSetHiglitedText, font: UIFont(font: .robotoBold, size: 20))
            questionTextFieldBackgroundView.isHidden = true
            questionTextField.isHidden = true
            stackView.isHidden = true
            questionTextField.resignFirstResponder()
        case .addingQuestion:
            enableMainButton(text: questionTextField.text)
            questionTextField.becomeFirstResponder()
            stateTitleLabel.text = Constants.hereWeAre
            stateTitleLabel.highlight(text: Constants.hereWeAreHighlited, font: UIFont(font: .robotoBold, size: 20))
            mainButton.setTitle(Constants.saveTitle, for: .normal)
            creatingDiceQuestionView.isHidden = true
            questionTextField.isHidden = false
            questionTextFieldBackgroundView.isHidden = false
            stackView.isHidden = false
        case .checking:
            stateTitleLabel.text = Constants.weAreSetTitle
            stateTitleLabel.highlight(text: Constants.weAreSetHiglitedText, font: UIFont(font: .robotoBold, size: 20))
            creatingDiceQuestionView.isHidden = false
            addRedGreenGradient()
            mainButton.setTitle(Constants.nextTitle, for: .normal)
            questionTextFieldBackgroundView.isHidden = true
            questionTextField.isHidden = true
            stackView.isHidden = true
            letsButton.isHidden = true
            noteLabel.isHidden = true
            clickButton.isHidden = true
            mainButton.isHidden = false
            
        case .letsDice:
            stateTitleLabel.text = Constants.letsDice
            letsButton.isHidden = false
            mainButton.setTitle(Constants.saveTitle, for: .normal)
            questionTextFieldBackgroundView.isHidden = true
            questionTextField.isHidden = true
            stackView.isHidden = true
            noteLabel.isHidden = false
            clickButton.isHidden = false
            creatingDiceQuestionView.isHidden = true
            mainButton.isHidden = true
            imageView.isHidden = true
        case .loading:
            let resultLogoSize = resized(size: CGSize(width: 196, height: 262), basedOn: .height)
            imageViewWidthAnchor.constant = resultLogoSize.width
            imageViewHeightAnchor.constant = resultLogoSize.height
            imageViewCenterYAnchor.constant = 0
            imageView.image = nil
            stateTitleLabel.text = Constants.waitAseconds
            backButton.isHidden = true
            backButtonLabel.isHidden = true
            imageView.isHidden = false
            noteLabel.isHidden = true
            clickButton.isHidden = true
            letsButton.isHidden = true
            mainButton.isHidden = true
            stateTitleLabelTopAnchor.isActive = false
            stateTitleLabelBottomAnchor.isActive = true
            
        case .showResult(let result):
            mainButton.setTitle(Constants.ok, for: .normal)
            mainButton.isHidden = false
            stateTitleLabel.text = result.title
            mainButton.alpha = 1

            questionTextField.text = nil
            isQuestionExist = false
            switch result {
            case .yes(let count), .no(let count):
                imageView.image = UIImage(named: "fire\(count)")
                mainButton.setTitle(Constants.ok, for: .normal)
            case .dontKnow:
                imageView.image = UIImage(named: "fire3")
            }
            UIView.animate(withDuration: 0.3) {
                self.imageView.alpha = 1
            }
        }
    }
    
    func enableMainButton(text: String?, forceDisable: Bool = false) {
        guard
            !forceDisable,
            let text = text,
            text.count > 3
        else {
            mainButton.alpha = 0.5
            isQuestionExist = false
            return
        }
        creatingDiceQuestionView.addButton.setTitle(questionTextField.text, for: .normal)
        isQuestionExist = true
        mainButton.alpha = 1
    }
    
    func showLoadingStateWith(number: Int) {
        imageView.image = UIImage(named: "fire\(number)")
    }
    
    private func addRedGreenGradient() {
        creatingDiceQuestionView.yesButton.layerGradient(startPoint: .bottomRight,
                                                         endPoint: .topLeft,
                                                         colorArray: [UIColor(netHex: 0x179B6C).cgColor,
                                                                      UIColor(netHex: 0x5FF12C).cgColor],
                                                         type: .axial)
        creatingDiceQuestionView.noButton.layerGradient(startPoint: .bottomRight,
                                                         endPoint: .topLeft,
                                                         colorArray: [UIColor(netHex: 0x9B172C).cgColor,
                                                                      UIColor(netHex: 0xF12C4C).cgColor],
                                                         type: .axial)
    }
    
    private func setupView() {
        backgroundColor = .AppCollors.background
        
        addSubview(imageView)
        let imageViewSize = resized(size: CGSize(width: 250, height: 350), basedOn: .height)
        imageView.centerXAnchor.constraint(equalTo: imageView.superview!.centerXAnchor).isActive = true
        imageViewCenterYAnchor = imageView.centerYAnchor.constraint(equalTo: imageView.superview!.centerYAnchor, constant: -70)
        imageViewWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: imageViewSize.width)
        imageViewWidthAnchor.isActive = true
        imageViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: imageViewSize.height)
        imageViewHeightAnchor.isActive = true
        imageViewCenterYAnchor.isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainButton)
        let mainButtonSize = resized(size: CGSize(width: 271, height: 60), basedOn: .height)
        mainButton.centerXAnchor.constraint(equalTo: mainButton.superview!.centerXAnchor).isActive = true
        mainButton.heightAnchor.constraint(equalToConstant: mainButtonSize.height).isActive = true
        mainButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 44).isActive = true
        mainButton.widthAnchor.constraint(equalToConstant: mainButtonSize.width).isActive = true
        mainButton.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backButton)
        let backButtonSize = resized(size: CGSize(width: 40, height: 40), basedOn: .height)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.widthAnchor.constraint(equalToConstant: backButtonSize.width),
            backButton.heightAnchor.constraint(equalToConstant: backButtonSize.height),
            backButton.topAnchor.constraint(equalTo: backButton.superview!.safeTopAnchor, constant: adapted(dimensionSize: 68, to: .height)),
            backButton.centerXAnchor.constraint(equalTo: backButton.superview!.centerXAnchor)
        ])
        
        addSubview(backButtonLabel)
        backButtonLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButtonLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 4),
            backButtonLabel.centerXAnchor.constraint(equalTo: backButton.superview!.centerXAnchor),
        ])
        
        addSubview(stateTitleLabel)
        stateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        stateTitleLabelTopAnchor = stateTitleLabel.topAnchor.constraint(equalTo: backButtonLabel.bottomAnchor, constant: 19)
        stateTitleLabelTopAnchor.isActive = true
        stateTitleLabelBottomAnchor = stateTitleLabel.bottomAnchor.constraint(equalTo: imageView.topAnchor, constant: -38)
        NSLayoutConstraint.activate([
            stateTitleLabel.leftAnchor.constraint(equalTo: stateTitleLabel.superview!.leftAnchor, constant: 52),
            stateTitleLabel.rightAnchor.constraint(equalTo: stateTitleLabel.superview!.rightAnchor, constant: -52)
        ])
        
        addSubview(questionTextFieldBackgroundView)
        questionTextFieldBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTextFieldBackgroundView.topAnchor.constraint(equalTo: stateTitleLabel.bottomAnchor, constant: 19),
            questionTextFieldBackgroundView.leftAnchor.constraint(equalTo: questionTextFieldBackgroundView.superview!.leftAnchor, constant: 52),
            questionTextFieldBackgroundView.rightAnchor.constraint(equalTo: questionTextFieldBackgroundView.superview!.rightAnchor, constant: -52),
            questionTextFieldBackgroundView.heightAnchor.constraint(equalToConstant: CGFloat(81).dp)
        ])
       
        questionTextFieldBackgroundView.addSubview(questionTextField)
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            questionTextField.centerYAnchor.constraint(equalTo: questionTextField.superview!.centerYAnchor),
            questionTextField.leftAnchor.constraint(equalTo: questionTextField.superview!.leftAnchor, constant: 20),
            questionTextField.rightAnchor.constraint(equalTo: questionTextField.superview!.rightAnchor, constant: -20),
            questionTextField.heightAnchor.constraint(equalToConstant: CGFloat(32).dp)
        ])
        
        addSubview(creatingDiceQuestionView)
        creatingDiceQuestionView.translatesAutoresizingMaskIntoConstraints = false
        let creatingDiceQuestionViewSize = resized(size: CGSize(width: 271, height: 187), basedOn: .height)
        NSLayoutConstraint.activate([
            creatingDiceQuestionView.topAnchor.constraint(equalTo: stateTitleLabel.bottomAnchor, constant: 19),
            creatingDiceQuestionView.centerXAnchor.constraint(equalTo: creatingDiceQuestionView.superview!.centerXAnchor),
            creatingDiceQuestionView.widthAnchor.constraint(equalToConstant: creatingDiceQuestionViewSize.width),
            creatingDiceQuestionView.heightAnchor.constraint(equalToConstant: creatingDiceQuestionViewSize.height)
        ])
        
        // StackView
        addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: questionTextFieldBackgroundView.bottomAnchor, constant: 10).isActive = true
        stackView.bottomAnchor.constraint(lessThanOrEqualTo: stackView.superview!.bottomAnchor, constant: 0).isActive = true
        stackView.leftAnchor.constraint(equalTo: questionTextFieldBackgroundView.leftAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: questionTextFieldBackgroundView.rightAnchor).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // PrivacyCheckBox
        stackView.addArrangedSubview(privacyCheckBox)
        privacyCheckBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        privacyCheckBox.translatesAutoresizingMaskIntoConstraints = false
        
        // TermsCheckBox
        stackView.addArrangedSubview(termsCheckBox)
        termsCheckBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        termsCheckBox.translatesAutoresizingMaskIntoConstraints = false
        
        // UserGeneratedCheckBox
        stackView.addArrangedSubview(userGeneratedCheckBox)
        userGeneratedCheckBox.heightAnchor.constraint(equalToConstant: 20).isActive = true
        userGeneratedCheckBox.translatesAutoresizingMaskIntoConstraints = false
        
        // Lets click
        addSubview(letsButton)
        let letsDiceButtonSize = resized(size: CGSize(width: 266, height: 266), basedOn: .height)
        letsButton.widthAnchor.constraint(equalToConstant: letsDiceButtonSize.width).isActive = true
        letsButton.heightAnchor.constraint(equalToConstant: letsDiceButtonSize.height).isActive = true
        letsButton.topAnchor.constraint(equalTo: stateTitleLabel.bottomAnchor, constant: adapted(dimensionSize: 69, to: .height)).isActive = true
        letsButton.centerXAnchor.constraint(equalTo: letsButton.superview!.centerXAnchor, constant: 0).isActive = true
        letsButton.translatesAutoresizingMaskIntoConstraints = false
        
        letsButton.addSubview(clickButton)
        clickButton.topAnchor.constraint(equalTo: clickButton.superview!.topAnchor).isActive = true
        clickButton.leftAnchor.constraint(equalTo: clickButton.superview!.leftAnchor).isActive = true
        clickButton.rightAnchor.constraint(equalTo: clickButton.superview!.rightAnchor).isActive = true
        clickButton.bottomAnchor.constraint(equalTo: clickButton.superview!.bottomAnchor).isActive = true
        clickButton.translatesAutoresizingMaskIntoConstraints = false
        
        // Note
        addSubview(noteLabel)
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            noteLabel.leftAnchor.constraint(equalTo: noteLabel.superview!.leftAnchor, constant: 52),
            noteLabel.rightAnchor.constraint(equalTo: noteLabel.superview!.rightAnchor, constant: -52),
            noteLabel.bottomAnchor.constraint(greaterThanOrEqualTo: noteLabel.superview!.bottomAnchor, constant: -adapted(dimensionSize: 159, to: .height)),
            noteLabel.topAnchor.constraint(greaterThanOrEqualTo: letsButton.bottomAnchor, constant: adapted(dimensionSize: 27, to: .height))
        ])
    }
}

private extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
