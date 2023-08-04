//
//  CheckboxAnimater.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/17.
//

import UIKit

class CheckboxAnimater {
    
    var duration: Double
    
    init(duration: Double = CheckboxDefaultValue.defaultAnimationDuration) {
        self.duration = duration
    }
    
    func morphAnimation(from fromPath: UIBezierPath, to toPath: UIBezierPath) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "path")
        animation.fromValue = fromPath.cgPath
        animation.toValue = toPath.cgPath
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.isRemovedOnCompletion = false
        
        return animation
    }
    
    func quickAnimation(_ key: String, reverse: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key)
        // Set the start and end.
        if !reverse {
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.timingFunction = CAMediaTimingFunction(name: .easeIn)
        } else {
            animation.fromValue = 1.0
            animation.toValue = 0.0
            animation.beginTime = CACurrentMediaTime() + (duration * 0.9)
            animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        }
        // Set animation properties.
        animation.duration = duration / 10.0
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        return animation
    }
    
    func animation(_ key: String, reverse: Bool) -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: key)
        // Set the start and end.
        if !reverse {
            animation.fromValue = 0.0
            animation.toValue = 1.0
        } else {
            animation.fromValue = 1.0
            animation.toValue = 0.0
        }
        // Set animation properties.
        animation.duration = duration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        
        return animation
    }
    
    func strokeAnimation(reverse: Bool = false) -> CABasicAnimation {
        return animation("strokeEnd", reverse: reverse)
    }
    
    func fillAnimation(numberOfBounces: Int, amplitude: CGFloat, reverse: Bool = true) -> CAKeyframeAnimation {
        var values = [CATransform3D]()
        var keyTimes = [Float]()
        
        // Add the start scale
        if !reverse {
            values.append(CATransform3DMakeScale(0.0, 0.0, 0.0))
        } else {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        }
        keyTimes.append(0.0)
        
        // Add the bounces.
        if numberOfBounces > 0 {
            for i in 1...numberOfBounces {
                let scale = i % 2 == 1 ? (1.0 + (amplitude / CGFloat(i))) : (1.0 - (amplitude / CGFloat(i)))
                let time = (Float(i) * 1.0) / Float(numberOfBounces + 1)
                
                values.append(CATransform3DMakeScale(scale, scale, scale))
                keyTimes.append(time)
            }
        }
        
        // Add the end scale.
        if !reverse {
            values.append(CATransform3DMakeScale(1.0, 1.0, 1.0))
        } else {
            values.append(CATransform3DMakeScale(0.0001, 0.0001, 0.0001))
        }
        keyTimes.append(1.0)
        
        // Create the animation.
        let animation = CAKeyframeAnimation(keyPath: "transform")
        animation.values = values.map({ NSValue(caTransform3D: $0) })
        animation.keyTimes = keyTimes.map({ NSNumber(value: $0 as Float) })
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        return animation
    }
    
    func quickOpacityAnimation(reverse: Bool) -> CABasicAnimation {
        return quickAnimation("opacity", reverse: reverse)
    }
}
