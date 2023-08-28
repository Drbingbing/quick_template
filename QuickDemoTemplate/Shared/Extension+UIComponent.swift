//
//  Extension+UIComponent.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/25.
//

import UIKit
import UIComponent

extension Component {
    
    func shadow(_ radius: CGFloat, opacity: Float = 0.15) -> ViewUpdateComponent<ComponentViewComponent<ComponentView>> {
        view()
            .update {
                if #available(iOS 13.0, *) {
                    $0.layer.cornerCurve = .continuous
                }
                $0.layer.shadowColor = UIColor.gray.cgColor
                $0.layer.shadowOffset = CGSize(width: 0, height: radius / 2)
                $0.layer.shadowRadius = radius
                $0.layer.shadowOpacity = opacity
            }
    }
    
    func capsule() -> ViewUpdateComponent<ComponentViewComponent<ComponentView>> {
        view()
            .update {
                $0.layer.cornerRadius = min($0.frame.height, $0.frame.width) / 2
            }
    }
}


