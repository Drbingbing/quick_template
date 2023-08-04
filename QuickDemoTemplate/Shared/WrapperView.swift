//
//  WrapperView.swift
//  Recruit
//
//  Created by 鍾秉辰 on 2023/6/7.
//  Copyright © 2023 Daniel. All rights reserved.
//

import UIKit

class WrapperView<V: UIView>: BaseView {
    var contentView: V
    
    var inset: UIEdgeInsets = .zero {
        didSet {
            guard inset != oldValue else { return }
            setNeedsLayout()
        }
    }
    
    init() {
        contentView = V()
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        addSubview(contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frameWithoutTransform = bounds.inset(by: inset)
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.sizeThatFits(size.inset(by: inset)).inset(by: -inset)
    }
}
