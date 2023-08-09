//
//  BottomSheetFloatingPanelStyle.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/8.
//

import UIKit
import FloatingPanel

struct BottomSheetFloatingPanelStyle {
    
    var shadowSize = CGSize(width: 0, height: 2)
    
    var shadowColor: UIColor
    
    var shadowOpacity: Float
    
    var shadowRadius: CGFloat
    
    var backgroundColor: UIColor
    
    var cornerRadius: CGFloat
    
    init(
        shadowSize: CGSize = CGSize(width: 0, height: 2),
        shadowColor: UIColor = UIColor.systemGray,
        shadowOpacity: Float = 0.15,
        shadowRadius: CGFloat = 4,
        backgroundColor: UIColor = .white,
        cornerRadius: CGFloat = 4
    ) {
        self.shadowSize = shadowSize
        self.shadowColor = shadowColor
        self.shadowOpacity = shadowOpacity
        self.shadowRadius = shadowRadius
        self.backgroundColor = backgroundColor
        self.cornerRadius = cornerRadius
    }
    
    func asSurfaceAppearance() -> SurfaceAppearance {
        let appearance = SurfaceAppearance()
        let shadow = SurfaceAppearance.Shadow()
        shadow.color = shadowColor
        shadow.offset = shadowSize
        shadow.opacity = shadowOpacity
        shadow.radius = shadowRadius
        appearance.shadows = shadowOpacity == 0 ? [] : [shadow]
        appearance.backgroundColor = backgroundColor
        appearance.cornerRadius = cornerRadius
        
        return appearance
    }
}
