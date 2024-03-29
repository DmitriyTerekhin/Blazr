//
//  SettingsPresenter.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import Foundation

protocol ISettingsPresenter: AnyObject {
    func attachView(view: ISettingsView)
    func getDataSource() -> [SettingType]
    func settingWasTapped(type: SettingType)
}

protocol ISettingsView: AnyObject {
    func routeToWebSite(_ site: String)
    func showMessage(text: String)
    func showLoader()
    func hideLoader()
}

class SettingsPresenter: ISettingsPresenter {
    
    private enum Constants {
        static let baseURL: String = "https://BlazR.pw"
    }
    
    private weak var view: ISettingsView?
    private let networkService: INetworkService
    private let userInfoService: ISensentiveInfoService
    private let presentationAssembly: IPresentationAssembly
    private let purchasesService: IProductService
    private let database: IDatabaseService
    
    init(
        networkService: INetworkService,
        userInfoService: ISensentiveInfoService,
        presentationAssembly: IPresentationAssembly,
        productService: IProductService,
        databaseService: IDatabaseService
    ) {
        self.networkService = networkService
        self.userInfoService = userInfoService
        self.presentationAssembly = presentationAssembly
        self.purchasesService = productService
        self.database = databaseService
    }
    
    func attachView(view: ISettingsView) {
        self.view = view
    }
    
    func getDataSource() -> [SettingType] {
        var source: [SettingType] = [
            SettingType.feedback,
            SettingType.privacy,
            SettingType.terms,
            SettingType.restorePurchases,
            SettingType.clearAllBlazrs,
            SettingType.deleteAccount
        ]
        if !userInfoService.isPremiumActive() {
            source.insert(SettingType.buyPremium, at: 0)
        }
        return source
    }
    
    func settingWasTapped(type: SettingType) {
        switch type {
        case .buyPremium:
            buyRemoveAdd()
        case .feedback:
            view?.routeToWebSite("\(Constants.baseURL)/#three")
        case .privacy:
            view?.routeToWebSite("\(Constants.baseURL)/privacy.html")
        case .terms:
            view?.routeToWebSite("\(Constants.baseURL)/terms.html")
        case .clearAllBlazrs:
            database.deleteAllBlazrs { succeed in
                guard succeed else { return }
                view?.showMessage(text: "Succeed")
            }
        case .restorePurchases:
            restorePurchases()
        case .deleteAccount:
            deleteAccount()
        }
    }
    
    func buyRemoveAdd() {
        view?.showLoader()
        purchasesService.buyAddsOff { [ weak self] result in
            DispatchQueue.main.async {
                self?.view?.hideLoader()
                guard let strongSelf = self else { return }
                switch result {
                case .success(_):
                    strongSelf.sendToSucceedPurchases()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    private func deleteAccount() {
        networkService.deleteProfile { [weak self] result in
            DispatchQueue.main.async {
                guard let strongSelf = self else { return }
                switch result {
                case .success(_):
                    strongSelf.revokeAppleToken()
                    strongSelf.goToEnterScreen()
                case .failure(_):
                    strongSelf.goToEnterScreen()
                }
            }
        }
    }
    
    private func restorePurchases() {
        purchasesService.restorePurchases { [weak self] result in
            switch result {
            case .success:
                self?.sendToSucceedPurchases()
            case .failure(let error):
                self?.view?.showMessage(text: error.localizedDescription)
            }
        }
    }
    
    private func sendToSucceedPurchases() {
        networkService.addPremium { [weak self] result in
            guard let strongSelf = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let succesResult):
                    if succesResult.0 {
                        strongSelf.userInfoService.savePremium()
                        strongSelf.view?.showMessage(text: succesResult.1)
                    }
                case .failure(let error):
                    strongSelf.view?.showMessage(text: error.localizedDescription)
                }
            }
        }
    }
    
    private func revokeAppleToken() {
        guard let appleToken = userInfoService.getAppleToken() else { return }
        networkService.revokeToken(appleId: appleToken)
    }
    
    private func goToEnterScreen() {
        userInfoService.deleteAllInfo { _ in
            if #available(iOS 13.0, *) {
                (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(presentationAssembly.enterScreen())
            } else {
                (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(presentationAssembly.enterScreen())
            }
        }
    }
}
