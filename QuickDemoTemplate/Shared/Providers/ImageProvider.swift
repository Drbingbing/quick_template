//
//  ImageProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/30.
//

import UIKit

class ImageProvider: SimpleViewProvider {
    
    var imageView: TappableView<UIImageView> {
        return view(at: 0) as! TappableView<UIImageView>
    }
    
    init(identifier: String? = nil, image: UIImage?, width: CGFloat? = 12, height: CGFloat? = 12, inset: UIEdgeInsets = .zero, onTap: TapHandler? = nil) {
        
        let imageView = TappableView<UIImageView>()
        imageView.contentView.image = image
        imageView.contentView.tintColor = .white
        imageView.inset = inset
        
        var viewSize: (SimpleViewSizeSource.ViewSizeStrategy, SimpleViewSizeSource.ViewSizeStrategy) = (.fit, .fit)
        if let width = width {
            viewSize.0 = .absolute(width)
        }
        if let height = height {
            viewSize.1 = .absolute(height)
        }
        
        super.init(
            identifier: identifier,
            views: [imageView],
            sizeSource: SimpleViewSizeSource(sizeStrategy: viewSize),
            layout: FlowLayout(),
            tapHandler: onTap
        )
    }
    
    convenience init(identifier: String? = nil, systemName: String, width: CGFloat = 12, height: CGFloat = 12, inset: UIEdgeInsets = .zero, onTap: TapHandler? = nil) {
        self.init(identifier: identifier, image: UIImage(systemName: systemName), width: width, height: height, inset: inset, onTap: onTap)
    }
    
    convenience init(identifier: String? = nil, name: String, size: CGFloat? = nil, inset: UIEdgeInsets = .zero, onTap: TapHandler? = nil) {
        self.init(identifier: identifier, image: UIImage(named: name), width: size, height: size, inset: inset, onTap: onTap)
    }
    
    convenience init(identifier: String? = nil, name: String, width: CGFloat? = nil, height: CGFloat? = nil, inset: UIEdgeInsets = .zero, onTap: TapHandler? = nil) {
        self.init(identifier: identifier, image: UIImage(named: name), width: width, height: height, inset: inset, onTap: onTap)
    }
    
    @discardableResult
    func foregroundColor(_ color: UIColor) -> Self {
        imageView.contentView.tintColor = color
        return self
    }
    
    @discardableResult
    func renderingMode(_ mode: UIImage.RenderingMode) -> Self {
        imageView.contentView.image = imageView.contentView.image?.withRenderingMode(mode)
        return self
    }
    
    @discardableResult
    func rotate(_ degree: CGFloat) -> Self {
        imageView.transform = .identity.rotated(by: degree)
        return self
    }
}
