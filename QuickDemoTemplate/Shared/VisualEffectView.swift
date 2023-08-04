//
//  VisualEffectView.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/30.
//

import UIKit

class VisualEffectView<V: UIView>: BaseView {
    
    private let animator = UIViewPropertyAnimator(duration: 0.5, curve: .linear)
    private var animatorCompletionValue: CGFloat = 0.35
    private let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    var contentView: V
    
    var inset: UIEdgeInsets = .zero {
        didSet {
            guard inset != oldValue else { return }
            setNeedsLayout()
        }
    }
    
    deinit {
        animator.stopAnimation(true)
    }
    
    init() {
        contentView = V()
        super.init(frame: .zero)
    }
    
    override func viewDidLoad() {
        addSubview(visualEffectView)
        visualEffectView.contentView.addSubview(contentView)
        visualEffectView.clipsToBounds = true
        setTheme()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        visualEffectView.frameWithoutTransform = bounds.inset(by: inset)
        contentView.frame = visualEffectView.frame
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        contentView.sizeThatFits(size.inset(by: inset)).inset(by: -inset)
    }
    
    func blur(_ radius: CGFloat) {
        animatorCompletionValue = 1 - radius
        animator.fractionComplete = animatorCompletionValue
    }
    
    func radius(_ r: CGFloat) {
        layer.cornerRadius = r
        contentView.layer.cornerRadius = r
        visualEffectView.layer.cornerRadius = r
        
    }
    
    func setTheme() {
        visualEffectView.effect = nil
        visualEffectView.effect = UIBlurEffect(style: .light)
        animator.stopAnimation(true)
        animator.addAnimations {
            self.visualEffectView.effect = nil
        }
        animator.fractionComplete = animatorCompletionValue
    }
    
    func shadow() {
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.15
    }
}
