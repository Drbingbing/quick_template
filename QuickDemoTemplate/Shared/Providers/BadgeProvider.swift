//
//  BadgeProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/1.
//

import UIKit
import BaseToolbox

class BadgeProvider: SimpleViewProvider {
    
    private var badge: TappableView<SimpleBadgeView<UIView>> {
        return view(at: 0) as! TappableView<SimpleBadgeView<UIView>>
    }
    
    init(icon: UIView, @ProviderArrayBuilder sections: () -> [Provider]) {
        
        let badgeView = TappableView(view: SimpleBadgeView(badge: icon))
        badgeView.contentView.collectionView.isUserInteractionEnabled = false
        badgeView.contentView.collectionView.provider = ComposedProvider(sections: sections())
        
        super.init(
            identifier: nil,
            views: [badgeView],
            sizeSource: SimpleViewSizeSource(sizeStrategy: (.fit, .fit)),
            layout: FlowLayout()
        )
    }
    
    convenience init(imageName: String, @ProviderArrayBuilder sections: () -> [Provider]) {
        let imageView = UIImageView(image: UIImage(named: imageName))
        self.init(icon: imageView, sections: sections)
    }
    
    convenience init(systemName: String, @ProviderArrayBuilder sections: () -> [Provider]) {
        let imageView = UIImageView(image: UIImage(systemName: systemName))
        self.init(icon: imageView, sections: sections)
    }
    
    @discardableResult
    func badgeSize(width: CGFloat, height: CGFloat) -> Self {
        badge.contentView.badgeSize = CGSize(width: width, height: height)
        return self
    }
    
    @discardableResult
    func badgeColor(_ color: UIColor) -> Self {
        badge.contentView.badge.tintColor = color
        return self
    }
}

private class SimpleBadgeView<Badge: UIView>: BaseView {
    
    let badge: Badge
    let collectionView = CollectionView()
    
    var badgeSize: CGSize?
    
    init(badge: Badge) {
        self.badge = badge
        super.init(frame: .zero)
        accessibilityTraits = .button
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubview(collectionView)
        addSubview(badge)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frameWithoutTransform = bounds
        let badgeSize = self.badgeSize ?? badge.sizeThatFits(bounds.size)
        badge.frame = CGRect(center: bounds.topRight, size: badgeSize)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        collectionView.sizeThatFits(size)
    }
    
}
