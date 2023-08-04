//
//  MarkerRenderNode.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/18.
//

import UIKit

class MarkerRenderNode: CheckboxRenderNode {
    let layer = CAShapeLayer()
    var pathGenerator: CheckboxPathGenerator = CheckboxDefaultValue.defaultPath
    var theme = CheckboxDefaultValue.defaultTheme
    var state: AnimatableCheckbox.CheckState = CheckboxDefaultValue.defaultState
    var mark: AnimatableCheckbox.MarkShape = CheckboxDefaultValue.defaultMark
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
        pathGenerator.shape = toShape
    }
    
    func transformMark(from fromMark: AnimatableCheckbox.MarkShape, to toMark: AnimatableCheckbox.MarkShape) {
        var fromPath: CheckboxPathGenerator
        var toPath: CheckboxPathGenerator
        switch fromMark {
        case .tick:
            fromPath = TickPathGenerator()
        case .radio:
            fromPath = RadioPathGenerator()
        case .cross:
            fromPath = CrosPathGenerator()
        }
        fromPath.boxLineWidth = pathGenerator.boxLineWidth
        fromPath.cornerRadius = pathGenerator.cornerRadius
        fromPath.markLineWidth = pathGenerator.markLineWidth
        fromPath.shape = pathGenerator.shape
        
        switch toMark {
        case .tick:
            toPath = TickPathGenerator()
        case .radio:
            toPath = RadioPathGenerator()
        case .cross:
            toPath = CrosPathGenerator()
        }
        toPath.boxLineWidth = pathGenerator.boxLineWidth
        toPath.cornerRadius = pathGenerator.cornerRadius
        toPath.markLineWidth = pathGenerator.markLineWidth
        toPath.shape = pathGenerator.shape
        
        let fromMarkPath = fromPath.pathForMark(in: layer.bounds)
        let toMarkPath = toPath.pathForMark(in: layer.bounds)
        let morphAnimation = animator.morphAnimation(from: fromMarkPath, to: toMarkPath)
        
        CATransaction.begin()
        
        switch toMark {
        case .radio:
            layer.fillColor = theme.markColor.cgColor
        case .tick:
            layer.fillColor = nil
        case .cross:
            layer.fillColor = nil
        }
        
        CATransaction.setCompletionBlock {
            self.reset(to: self.state)
        }
        
        layer.add(morphAnimation, forKey: "path")
        
        CATransaction.commit()
        
        mark = toMark
        pathGenerator = toPath
    }
    
    func updateView(in rect: CGRect) {
        layer.frame = rect
        layer.lineWidth = pathGenerator.markLineWidth
        layer.path = pathGenerator.pathForMark(in: rect).cgPath
    }
    
    func makeView() -> CAShapeLayer {
        apply()
        layer.lineJoin = .round
        layer.lineCap = .round
        
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
            layer.add(strokeAnimation, forKey: "strokeEnd")
            layer.add(opacityAnimation, forKey: "opacity")
        case .fill:
            let opacityAnimation = animator.quickOpacityAnimation(reverse: toState == .unchecked)
            switch mark {
            case .tick, .cross:
                let strokeAnimation = animator.strokeAnimation(reverse: toState == .unchecked)
                layer.add(strokeAnimation, forKey: "strokeEnd")
            case .radio:
                break
            }
            layer.add(opacityAnimation, forKey: "opacity")
        case .bounce:
            let wiggleAnimation = animator.fillAnimation(numberOfBounces: 1, amplitude: 0.35, reverse: toState == .unchecked)
            layer.add(wiggleAnimation, forKey: "transform")
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
            layer.strokeColor = theme.markColor.cgColor
            layer.fillColor = nil
            layer.strokeEnd = state == .unchecked ? 0 : 1
            layer.opacity = state == .unchecked ? 0 : 1
            layer.transform = CATransform3DIdentity
        case .fill:
            layer.strokeColor = theme.secondaryMarkColor.cgColor
            layer.fillColor = nil
            layer.strokeEnd = 1
            layer.opacity = state == .unchecked ? 0 : 1
            layer.transform = CATransform3DIdentity
        case .bounce:
            layer.strokeColor = theme.markColor.cgColor
            layer.strokeEnd = 1
            layer.opacity = 1
            layer.transform = state == .checked ? CATransform3DIdentity : CATransform3DMakeScale(0, 0, 0)
            if pathGenerator is RadioPathGenerator {
                layer.fillColor = theme.markColor.cgColor
            } else {
                layer.fillColor = nil
            }
        }
        layer.lineWidth = pathGenerator.markLineWidth
        layer.path = pathGenerator.pathForMark(in: layer.bounds).cgPath
    }
}
