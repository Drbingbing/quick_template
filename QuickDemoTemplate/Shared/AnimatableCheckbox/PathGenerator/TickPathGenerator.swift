//
//  TickPathGenerator.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/17.
//
import UIKit

class TickPathGenerator: CheckboxPathGenerator {
    
    var boxLineWidth: CGFloat = CheckboxDefaultValue.defaultBoxLineWidth
    var markLineWidth: CGFloat = CheckboxDefaultValue.defaultMarkLineWidth
    var cornerRadius: CGFloat = CheckboxDefaultValue.defaultCornerRadius
    
    var shape: AnimatableCheckbox.BoxShape = CheckboxDefaultValue.defaultShape
    
    func pathForMark(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let size = min(rect.width, rect.height) - markLineWidth
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let checkmarkIntersectionPoint = CGPoint(x: center.x - size / 18, y: center.y + size / 4)
        let shortArmStartPoint = CGPoint(x: center.x - size / 4, y: center.y + size / 14)
        let longArmEndPoint = CGPoint(x: center.x + size / 5, y: center.y - size / 5)
        path.move(to: shortArmStartPoint)
        path.addLine(to: checkmarkIntersectionPoint)
        path.addLine(to: longArmEndPoint)
        
        return path
    }
    
    func pathForBox(in rect: CGRect) -> UIBezierPath {
        switch shape {
        case .square:
            return squarePath(in: rect)
        case .circle:
            return circlePath(in: rect)
        }
    }
    
}
