//
//  MessageAvator.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/17.
//

import UIKit
import BaseToolbox

class AvatorProvider: SimpleViewProvider {
    
    typealias SizeStrategy = (width: SimpleViewSizeSource.ViewSizeStrategy, height: SimpleViewSizeSource.ViewSizeStrategy)
    
    var avator: TappableView<AvatorView> {
        return view(at: 0) as! TappableView<AvatorView>
    }
    
    init(imagePath: String, size: CGSize? = nil) {
        let view = TappableView<AvatorView>()
        view.contentView.image = UIImage(named: imagePath)
        let sizeStrategy: SizeStrategy = (size == nil) ? (.fill, .fit) : (.absolute(size!.width), .absolute(size!.height))
        super.init(
            identifier: nil,
            views: [view],
            sizeSource: SimpleViewSizeSource(sizeStrategy: sizeStrategy),
            layout: FlowLayout()
        )
    }
    
    @discardableResult
    override func cornerRadius(_ r: CGFloat) -> Self {
        avator.contentView.cornerRadius(r)
        avator.layer.cornerRadius = r
        return self
    }
}

class AvatorView: BaseView {
    
    private let imageView = WrapperView<UIImageView>()
    
    var image: UIImage? {
        didSet {
            imageView.contentView.image = image
        }
    }
    
    var inset: UIEdgeInsets = .zero {
        didSet {
            guard inset != oldValue else { return }
            setNeedsLayout()
        }
    }
    
    override var tintColor: UIColor! {
        didSet {
            imageView.contentView.tintColor = tintColor
            imageView.tintColor = tintColor
        }
    }
    
    override func viewDidLoad() {
        addSubview(imageView)
        
        imageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frameWithoutTransform = bounds.inset(by: inset)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        imageView.sizeThatFits(size.inset(by: inset)).inset(by: -inset)
    }
    
    func cornerRadius(_ radius: CGFloat) {
        imageView.layer.cornerRadius = radius
        layer.cornerRadius = radius
    }
}
