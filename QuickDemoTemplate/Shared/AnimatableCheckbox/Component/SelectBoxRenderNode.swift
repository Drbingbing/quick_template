//
//  SelectBoxRenderNode.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/17.
//

import UIKit

class SelectBoxRenderNode: CheckboxRenderNode {
    let layer = CAShapeLayer()
    var pathGenerator: CheckboxPathGenerator = CheckboxDefaultValue.defaultPath
    var theme = CheckboxDefaultValue.defaultTheme
    var state: AnimatableCheckbox.CheckState = CheckboxDefaultValue.defaultState
    var animation: AnimatableCheckbox.Animation = CheckboxDefaultValue.defaultAnimation
    let animator = CheckboxAnimater()
    
    func apply(path: CheckboxPathGenerator) {
        self.pathGenerator = path
        self.apply()
    }
    
    func apply(theme: CheckboxColorTheme) {
        self.theme = theme
        self.apply()
    }
    
    func apply(animation: AnimatableCheckbox.Animation) {
        self.animation = animation
        self.apply()
    }
    
    func transformShape(from fromShape: AnimatableCheckbox.BoxShape, to toShape: AnimatableCheckbox.BoxShape) {
        CATransaction.begin()
        
        CATransaction.setCompletionBlock {
            self.reset(to: self.state)
        }
        
        pathGenerator.shape = fromShape
        let fromPath = pathGenerator.pathForBox(in: layer.bounds)
        pathGenerator.shape = toShape
        let toPath = pathGenerator.pathForBox(in: layer.bounds)
        let morphAnimation = animator.morphAnimation(from: fromPath, to: toPath)
        
        layer.add(morphAnimation, forKey: "path")
        
        CATransaction.commit()
    }
    
    func transformMark(from fromMark: AnimatableCheckbox.MarkShape, to toMark: AnimatableCheckbox.MarkShape) {
    }
    
    func updateView(in rect: CGRect) {
        layer.frame = rect
        layer.lineWidth = pathGenerator.boxLineWidth
        layer.path = pathGenerator.pathForBox(in: rect).cgPath
    }
    
    func makeView() -> CAShapeLayer {
        apply()
        
        return layer
    }
    
    func animate(from fromState: AnimatableCheckbox.CheckState, to toState: AnimatableCheckbox.CheckState) {
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.reset(to: toState)
        }
        
        switch animation {
        case .stroke:
            let strokeAnimation = animator.strokeAnimation(reverse: toState == .unchecked)
            let opacityAnimation = animator.quickOpacityAnimation(reverse: toState == .unchecked)
            layer.add(opacityAnimation, forKey: "opacity")
            layer.add(strokeAnimation, forKey: "strokeEnd")
        case .fill:
            let wiggleAnimation = animator.fillAnimation(numberOfBounces: 1, amplitude: 0.18, reverse: toState == .unchecked)
            layer.add(wiggleAnimation, forKey: "transform")
        case .bounce:
            let opacityAnimation = animator.quickOpacityAnimation(reverse: toState == .unchecked)
            layer.add(opacityAnimation, forKey: "opacity")
        }
        
        CATransaction.commit()
    }
    
    private func reset(to toState: AnimatableCheckbox.CheckState) {
        state = toState
        apply()
    }
    
    private func apply() {
        layer.removeAllAnimations()
        switch animation {
        case .stroke:
            layer.strokeColor = theme.tintColor.cgColor
            layer.fillColor = nil
            layer.strokeEnd = state == .unchecked ? 0 : 1
            layer.transform = CATransform3DIdentity
            layer.opacity = state == .checked ? 1 : 0
        case .fill:
            layer.strokeColor = theme.tintColor.cgColor
            layer.fillColor = theme.tintColor.cgColor
            layer.transform = state == .checked ? CATransform3DMakeScale(1, 1, 1) : CATransform3DMakeScale(0, 0, 0)
            layer.strokeEnd = 1
            layer.opacity = 1
        case .bounce:
            layer.strokeEnd = 1
            layer.strokeColor = theme.tintColor.cgColor
            layer.fillColor = nil
            layer.transform = CATransform3DIdentity
            layer.opacity = state == .checked ? 1 : 0
        }
        
        layer.path = pathGenerator.pathForBox(in: layer.bounds).cgPath
        layer.lineWidth = pathGenerator.boxLineWidth
    }
}
