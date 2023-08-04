//
//  SeparatorProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit

class SeparatorProvider: SimpleViewProvider {
    
    init(
        color: UIColor = .systemGray6,
        inset: UIEdgeInsets = .zero,
        height: CGFloat = 1
    ) {
        
        let separator = UIView()
        separator.backgroundColor = color
        
        super.init(
            identifier: nil,
            views: [separator],
            sizeSource: SimpleViewSizeSource(sizeStrategy: (.fill, .absolute(height))),
            layout: inset == .zero ? FlowLayout() : FlowLayout().inset(by: inset)
        )
    }
    
}
