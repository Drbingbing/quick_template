//
//  UnSelectBoxRenderNode.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/18.
//

import UIKit

class UnSelectBoxRenderNode: CheckboxRenderNode {
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
    
    func updateView(in rect: CGRect) {
        layer.frame = rect
        layer.path = pathGenerator.pathForBox(in: rect).cgPath
    }
    
    func makeView() -> CAShapeLayer {
        apply()
        
        return layer
    }
    
    func animate(from fromState: AnimatableCheckbox.CheckState, to toState: AnimatableCheckbox.CheckState) {
        reset(to: toState)
    }
    
    private func reset(to toState: AnimatableCheckbox.CheckState) {
        state = toState
        apply()
    }
    
    private func apply() {
        layer.removeAllAnimations()
        
        switch animation {
        case .stroke:
            layer.strokeColor = theme.secondaryColor.cgColor
            layer.fillColor = nil
        case .fill:
            layer.strokeColor = theme.secondaryColor.cgColor
            layer.fillColor = nil
        case .bounce:
            layer.strokeColor = theme.secondaryColor.cgColor
            layer.fillColor = nil
        }
        
        layer.lineWidth = pathGenerator.boxLineWidth
        layer.path = pathGenerator.pathForBox(in: layer.bounds).cgPath
    }
}

