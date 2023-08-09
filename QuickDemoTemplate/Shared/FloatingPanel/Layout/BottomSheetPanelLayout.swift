//
//  BottomSheetPanelLayout.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/8.
//

import UIKit
import FloatingPanel

class BottomSheetPanelLayout: FloatingPanelLayout {
    
    let position: FloatingPanelPosition = .bottom
    let initialState: FloatingPanelState = .tip
    
    let anchors: [FloatingPanelState : FloatingPanelLayoutAnchoring] = [
        .tip: FloatingPanelLayoutAnchor(absoluteInset: 44.0, edge: .bottom, referenceGuide: .safeArea)
    ]
    
    func backdropAlpha(for state: FloatingPanelState) -> CGFloat {
        return 0
    }
}
