//
//  GradientView.swift
//  Blazr
//
//  Created by Дмитрий Терехин on 09.12.2022.
//

import UIKit

class GradientButtonView: UIButton {
    
    private var gradientLayer = CAGradientLayer()

    func layerGradient(startPoint: CAGradientPoint,
                       endPoint: CAGradientPoint,
                       colorArray: [CGColor],
                       type: CAGradientLayerType) {
        gradientLayer.removeFromSuperlayer()
        gradientLayer = CAGradientLayer(start: startPoint, end: endPoint, colors: colorArray, type: type)
        gradientLayer.frame.size = self.frame.size
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

private extension CAGradientLayer {
    convenience init(start: CAGradientPoint, end: CAGradientPoint, colors: [CGColor], type: CAGradientLayerType) {
        self.init()
        self.frame.origin = CGPoint.zero
        self.startPoint = start.point
        self.endPoint = end.point
        self.colors = colors
        self.locations = (0..<colors.count).map(NSNumber.init)
        self.type = type
    }
}

enum CAGradientPoint {
    case topLeft
    case centerLeft
    case bottomLeft
    case topCenter
    case center
    case bottomCenter
    case topRight
    case centerRight
    case bottomRight
    var point: CGPoint {
        switch self {
        case .topLeft:
            return CGPoint(x: 0, y: 0)
        case .centerLeft:
            return CGPoint(x: 0, y: 0.5)
        case .bottomLeft:
            return CGPoint(x: 0, y: 1.0)
        case .topCenter:
            return CGPoint(x: 0.5, y: 0)
        case .center:
            return CGPoint(x: 0.5, y: 0.5)
        case .bottomCenter:
            return CGPoint(x: 0.5, y: 1.0)
        case .topRight:
            return CGPoint(x: 1.0, y: 0.0)
        case .centerRight:
            return CGPoint(x: 1.0, y: 0.5)
        case .bottomRight:
            return CGPoint(x: 1.0, y: 1.0)
        }
    }
}
