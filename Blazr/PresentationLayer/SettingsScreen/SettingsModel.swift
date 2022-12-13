//
//  SettingsModel.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 08.12.2022.
//

import Foundation

enum SettingType: CaseIterable {
    case buyPremium
    case feedback
    case privacy
    case terms
    case clearAllBlazrs
    case restorePurchases
    case deleteAccount
    
    var title: String {
        switch self {
        case .buyPremium:
            return "Buy premium"
        case .feedback:
            return "Send feedback"
        case .privacy:
            return "Privacy policy"
        case .clearAllBlazrs:
            return "Clear all Blazrs"
        case .terms:
            return "Terms of use"
        case .restorePurchases:
            return "Restore purchase"
        case .deleteAccount:
            return "Delete account"
        }
    }
}
