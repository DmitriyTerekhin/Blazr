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
    
}

class SettingsPresenter: ISettingsPresenter {
    
    private weak var view: ISettingsView?
    private let networkService: INetworkService
    private let userInfoService: ISensentiveInfoService
    private let presentationAssembly: IPresentationAssembly
    private let purchasesService: IProductService
    
    init(
        networkService: INetworkService,
        userInfoService: ISensentiveInfoService,
        presentationAssembly: IPresentationAssembly,
        productService: IProductService
    ) {
        self.networkService = networkService
        self.userInfoService = userInfoService
        self.presentationAssembly = presentationAssembly
        self.purchasesService = productService
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
            SettingType.deleteAccount
        ]
        if !userInfoService.isPremiumActive() {
            source.insert(SettingType.buyPremium, at: 0)
        }
        return source
    }
    
    func settingWasTapped(type: SettingType) {
        print("\(type)")
    }
}
