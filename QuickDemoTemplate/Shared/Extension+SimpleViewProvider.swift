//
//  Extension+SimpleViewProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/20.
//

import UIKit

@objc
extension SimpleViewProvider {
    
    @discardableResult
    func border(_ color: UIColor, width: CGFloat = 1) -> Self {
        view(at: 0).layer.borderColor = color.cgColor
        view(at: 0).layer.borderWidth = width
        return self
    }
    
    @discardableResult
    func background(_ color: UIColor) -> Self {
        view(at: 0).backgroundColor = color
        return self
    }
    
    @discardableResult
    func cornerRadius(_ r: CGFloat) -> Self {
        view(at: 0).layer.cornerRadius = r
        return self
    }
    
    @discardableResult
    func shadow(_ radius: CGFloat, color: UIColor = UIColor(hexString: "979797"), opacity: Float = 0.15) -> Self {
        view(at: 0).layer.shadowOffset = CGSize(width: 0, height: radius / 2)
        view(at: 0).layer.shadowColor = color.cgColor
        view(at: 0).layer.shadowRadius = radius
        view(at: 0).layer.shadowOpacity = opacity
        return self
    }
    
}

extension SimpleViewProvider {
    
    convenience init (
        layout: Layout = FlowLayout(),
        sizeSource: SizeSource<UIView> = SimpleViewSizeSource(sizeStrategy: (.fit, .fit)),
        content: () -> [UIView]
    ) {
        self.init(views: content(), sizeSource: sizeSource, layout: layout)
    }
    
    @discardableResult
    func onTap(_ tap: TapHandler?) -> Self {
        tapHandler = tap
        return self
    }
    
    @discardableResult
    func size(width: SimpleViewSizeSource.ViewSizeStrategy? = nil, height: SimpleViewSizeSource.ViewSizeStrategy? = nil) -> Self {
        
        let size = SimpleViewSizeSource(sizeStrategy: (.fit, .fit))
        if let width = width {
            size.sizeStrategy.width = width
        }
        if let height = height {
            size.sizeStrategy.height = height
        }
        
        sizeSource = size
        
        return self
    }
}
