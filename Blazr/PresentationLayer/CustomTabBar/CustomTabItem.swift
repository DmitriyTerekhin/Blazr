//
//  CustomTabItem.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 07.12.2022.
//

import UIKit

enum CustomTabItemType {
    case dice
    case blazr
    case settings
}

struct CustomTabItem: Equatable {
    let type: CustomTabItemType
    let viewController: UIViewController
    
    var icon: UIImage? {
        type.icon
    }
    
    var selectedIcon: UIImage? {
        type.selectedIcon
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.type == rhs.type
    }
}

extension CustomTabItemType {

    var icon: UIImage? {
        switch self {
        case .dice:
            return UIImage(named: "Dark_Dice")
        case .blazr:
            return UIImage(named: "Dark_Blazr")
        case .settings:
            return UIImage(named: "Dark_Settings")
        }
    }

    var selectedIcon: UIImage? {
        switch self {
        case .dice:
            return UIImage(named: "Red_Dice")
        case .blazr:
            return UIImage(named: "Red_Blazr")
        case .settings:
            return UIImage(named: "Red_Settings")
        }
    }
    
    var title: String {
        switch self {
        case .dice:
            return "Dice"
        case .blazr:
            return "Blazr"
        case .settings:
            return "Setting"
        }
    }
}
