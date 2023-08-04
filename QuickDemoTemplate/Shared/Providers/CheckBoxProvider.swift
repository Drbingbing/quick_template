//
//  CheckBoxProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import UIKit
import BaseToolbox

class CheckBoxProvider: SimpleViewProvider {
    
    var contentView: TappableView<UIImageView> {
        return view(at: 0) as! TappableView<UIImageView>
    }
    
    init(checked: Bool, width: CGFloat = 16, height: CGFloat = 16) {
        let view = WrapperView<UIImageView>()
        view.contentView.image = checked ? UIImage(named: "icon _tick square_") : UIImage(named: "icon_tick_uncheck_square")
        view.contentView.image = view.contentView.image?.withRenderingMode(.alwaysTemplate)
        view.contentView.tintColor = checked ? UIColor(hexString: "FF99AC") : .systemGray4
        view.inset = UIEdgeInsets(1)
        
        let viewSize: (SimpleViewSizeSource.ViewSizeStrategy, SimpleViewSizeSource.ViewSizeStrategy) = (.absolute(width), .absolute(height))
        
        super.init(
            identifier: nil,
            views: [view],
            sizeSource: SimpleViewSizeSource(sizeStrategy: viewSize),
            layout: FlowLayout()
        )
    }
    
    @discardableResult
    func onTap(_ tap: (() -> Void)?) -> Self {
        contentView.onTap = tap
        return self
    }
}
