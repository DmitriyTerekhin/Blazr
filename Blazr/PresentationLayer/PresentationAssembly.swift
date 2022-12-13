//
//  PresentationAssembly.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import Foundation
import UIKit

protocol IPresentationAssembly {
    func enterScreen() -> EnterViewController
    func askPermissionsScreen(link: String?) -> AskPermissionsViewController
    func tabbarController() -> CustomTabBarController
    func creatingDiceScreen() -> CreatingDiceViewController
    func blazrsScreen() -> BlazrViewController
    func webViewController(site: String, title: String?) -> WebViewViewController
    func settingsScreen() -> SettingsViewController
    func getCountryCheckScreen() -> LaunchScreenViewController
//    func getLoaderScreen() -> LoaderViewController
}

class PresentationAssembly: IPresentationAssembly {
    
    let serviceAssembly: IServiceAssembly
    
    init(serviceAssembly: IServiceAssembly) {
        self.serviceAssembly = serviceAssembly
    }
    
    func getCountryCheckScreen() -> LaunchScreenViewController {
        LaunchScreenViewController(networkService: serviceAssembly.networkService,
                                   presentationAssembly: self,
                                   userInfoService: serviceAssembly.userInfoService,
                                   purchasesService: serviceAssembly.purchasesService,
                                   contentView: LaunchScreenView())
    }

    func enterScreen() -> EnterViewController {
        EnterViewController(presentationAssembly: self,
                            userInfoService: serviceAssembly.userInfoService,
                            networkService: serviceAssembly.networkService)
    }

    func webViewController(site: String, title: String? = nil) -> WebViewViewController {
        WebViewViewController(site: site, title: title)
    }

    func askPermissionsScreen(link: String?) -> AskPermissionsViewController {
        AskPermissionsViewController(presentationAssembly: self,
                                     userInfoService: serviceAssembly.userInfoService)
    }
    
    func creatingDiceScreen() -> CreatingDiceViewController {
        CreatingDiceViewController(presenter: CreatingQuestionPresenter(databaseService: serviceAssembly.databaseService))
    }
    
    func blazrsScreen() -> BlazrViewController {
        BlazrViewController(database: serviceAssembly.databaseService)
    }

    func settingsScreen() -> SettingsViewController {
        SettingsViewController(
                               presenter: SettingsPresenter(networkService: serviceAssembly.networkService,
                                                            userInfoService: serviceAssembly.userInfoService,
                                                            presentationAssembly: self,
                                                            productService: serviceAssembly.purchasesService),
                               presentationAssembly: self)
    }
    func tabbarController() -> CustomTabBarController {
        CustomTabBarController(tabBar: CustomTabBar(presentationAssembly: self))
    }
//    func getLoaderScreen() -> LoaderViewController {
//        let loaderVC = LoaderViewController()
//        loaderVC.modalPresentationStyle = .overCurrentContext
//        return loaderVC
//    }
    
}
