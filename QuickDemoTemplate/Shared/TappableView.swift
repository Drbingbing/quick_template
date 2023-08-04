//
//  TappableView.swift
//  Recruit
//
//  Created by 鍾秉辰 on 2023/6/8.
//  Copyright © 2023 Daniel. All rights reserved.
//
import UIKit

struct TappableViewConfiguration {
    static var `default` = TappableViewConfiguration(onHighlightChanged: nil, didTap: nil)

    // place to apply highlight state or animation to the TappableView
    var onHighlightChanged: ((UIView, Bool) -> Void)?

    // hook before the actual onTap is called
    var didTap: (() -> Void)?

    init(onHighlightChanged: ((UIView, Bool) -> Void)? = nil, didTap: (() -> Void)? = nil) {
        self.onHighlightChanged = onHighlightChanged
        self.didTap = didTap
    }
}

class TappableView<V: UIView>: BaseView {
    
    var configuration: TappableViewConfiguration?
    var tapAnimation: Bool = true
    
    private(set) lazy var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
    
    var isHighlighted: Bool = false {
        didSet {
            guard isHighlighted != oldValue else { return }
            guard tapAnimation else { return }
            let config = configuration ?? TappableViewConfiguration.default
            config.onHighlightChanged?(self, isHighlighted)
        }
    }
    
    var onTap: (() -> Void)? {
        didSet {
            if onTap != nil {
                addGestureRecognizer(tapGestureRecognizer)
            } else {
                removeGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    var contentView: V
    
    var inset: UIEdgeInsets = .zero {
        didSet {
            guard inset != oldValue else { return }
            setNeedsLayout()
        }
    }
    
    init(view: V) {
        contentView = view
        super.init(frame: .zero)
        accessibilityTraits = .button
    }
    
    init() {
        contentView = V()
        super.init(frame: .zero)
        accessibilityTraits = .button
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
    
    @objc func didTap() {
        let config = configuration ?? TappableViewConfiguration.default
        config.didTap?()
        onTap?()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isHighlighted = true
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        isHighlighted = false
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        isHighlighted = false
    }
}
