//
//  LabelProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/30.
//

import UIKit

class LabelProvider: SimpleViewProvider {
    
    var view: TappableView<UILabel> {
        return view(at: 0) as! TappableView<UILabel>
    }
    
    init(
        identifier: String? = nil,
        text: String,
        color: UIColor = .gray1,
        font: UIFont = .qt_body(),
        inset: UIEdgeInsets = .zero,
        width: SimpleViewSizeSource.ViewSizeStrategy = .fit,
        height: SimpleViewSizeSource.ViewSizeStrategy = .fit,
        tapHandler: TapHandler? = nil
    ) {
        let view = TappableView<UILabel>()
        view.contentView.text = text
        view.contentView.textColor = color
        view.contentView.font = font
        view.contentView.numberOfLines = 0
        view.inset = inset
        
        super.init(
            identifier: identifier,
            views: [view],
            sizeSource: SimpleViewSizeSource(sizeStrategy: (width, height)),
            layout: FlowLayout(),
            tapHandler: tapHandler
        )
    }
    
    @discardableResult
    func alignment(_ alignment: NSTextAlignment) -> Self {
        view.contentView.textAlignment = alignment
        return self
    }
    
    @discardableResult
    func padding(_ padding: UIEdgeInsets) -> Self {
        view.inset = padding
        return self
    }
    
    @discardableResult
    func padding(_ value: CGFloat, _ position: PaddingPosition = [.horizontal, .vertical]) -> Self {
        var edge = UIEdgeInsets(0)
        if position.contains(.horizontal) {
            edge.left = value
            edge.right = value
        }
        if position.contains(.vertical) {
            edge.top = value
            edge.bottom = value
        }
        
        view.inset = edge + view.inset
        return self
    }
}

struct PaddingPosition: OptionSet {
    let rawValue: Int
    
    static let horizontal = PaddingPosition(rawValue: 1)
    static let vertical = PaddingPosition(rawValue: 2)
}

func + (lhs: UIEdgeInsets, rhs: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(top: lhs.top + rhs.top, left: lhs.left + rhs.left, bottom: lhs.bottom + rhs.bottom, right: lhs.right + rhs.right)
}
