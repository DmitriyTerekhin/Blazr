//
//  CreatingDiceViewController.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import UIKit

class CreatingDiceViewController: UIViewController {
    
    private var agreeWithPrivacy = true
    private var agreeWithTerms = true
    private var agreeWithUserContent = true
    private var allAgree: Bool {
        guard agreeWithTerms else { return false }
        guard agreeWithPrivacy else { return false }
        guard agreeWithUserContent else { return false}
        return true
    }
    
    private let contentView = CreatingView()
    private let presenter: ICreatingQuestionPresenter
    private var needToStoptimer: Bool = true
    private var timer: Timer = Timer(timeInterval: -1,
                                     target: CreatingDiceViewController.self,
                                     selector: #selector(CreatingDiceViewController.showLoading),
                                     userInfo: nil,
                                     repeats: false)

    private var viewState: CreatingDiceViewState = .initial {
        didSet {
            contentView.prepareViewFor(state: viewState)
        }
    }
    
    init(presenter: ICreatingQuestionPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc
    func letsDiceTapped() {
        viewState = .loading
        timer.invalidate()
        needToStoptimer = false
        showLoading2()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(10)) {
            self.needToStoptimer = true
            self.timer.invalidate()
            guard
                let result = self.presenter.diceResult,
                let diceResult = DiceResult(number: result)
            else { return }
            self.presenter.saveResult(question: self.contentView.questionTextField.text ?? "")
            self.viewState = .showResult(result: diceResult)
        }
    }
    
    @objc
    func showLoading2() {
        guard !needToStoptimer else { return }
        UIView.animate(
            withDuration: 0.15,
            animations: {
                self.contentView.imageView.alpha = 0
            }) { _ in
                guard !self.needToStoptimer else { return }
                self.contentView.showLoadingStateWith(number: self.presenter.getRandomNumber())
                UIView.animate(withDuration: 0.15,
                               animations: {
                    self.contentView.imageView.alpha = 1
                },
                               completion: { _ in
                    guard !self.needToStoptimer else { return }
                    self.showLoading2()
                }
                )
            }
    }
    
    @objc
    func showLoading() {
        contentView.showLoadingStateWith(number: presenter.getRandomNumber())
        guard
            !needToStoptimer
        else { return }
        // Restart the timer
        timer = Timer.scheduledTimer(
            timeInterval: 1/3, //This is the time interval you don't want to do nothing
            target: self,
            selector: #selector(CreatingDiceViewController.showLoading),
            userInfo: nil,
            repeats: false)
    }
    
    @objc
    func addQuestionTapped() {
        viewState = .addingQuestion
        textFieldValueDidChanged(sender: contentView.questionTextField)
    }

    @objc
    func mainButtonTapped() {
        switch viewState {
        case .initial:
            viewState = .startCreating
        case .addingQuestion:
            guard contentView.isQuestionExist else { return }
            viewState = .checking
        case .checking:
            viewState = .letsDice
        case .letsDice:
            viewState = .loading
        case .showResult:
            viewState = .initial
        default:
            break
        }
    }
    
    @objc
    func backButtonTapped() {
        switch viewState {
        case .initial:
            break
        case .startCreating:
            viewState = .initial
        case .addingQuestion:
            viewState = .startCreating
        case .checking:
            viewState = .startCreating
        case .letsDice:
            viewState = .checking
        case .showResult:
            viewState = .letsDice
        default:
            break
        }
    }
    
    @objc
    func checkBoxTapped(sender: UIButton) {
        switch sender.tag {
        case 1:
            contentView.privacyCheckBox.checkBoxButtonTapped()
            agreeWithPrivacy = contentView.privacyCheckBox.turnOn
        case 2:
            contentView.termsCheckBox.checkBoxButtonTapped()
            agreeWithTerms = contentView.termsCheckBox.turnOn
        case 3:
            contentView.userGeneratedCheckBox.checkBoxButtonTapped()
            agreeWithUserContent = contentView.userGeneratedCheckBox.turnOn
        default:
            break
        }
        contentView.enableMainButton(text: contentView.questionTextField.text, forceDisable: !allAgree)
    }
    
    @objc
    func textFieldValueDidChanged(sender: UITextField) {
        contentView.enableMainButton(text: sender.text, forceDisable: !allAgree)
    }
}
