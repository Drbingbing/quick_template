//
//  RadioPathGenerator.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/20.
//

import UIKit

class RadioPathGenerator: CheckboxPathGenerator {
    
    var boxLineWidth: CGFloat = CheckboxDefaultValue.defaultBoxLineWidth
    var markLineWidth: CGFloat = CheckboxDefaultValue.defaultMarkLineWidth
    var cornerRadius: CGFloat = CheckboxDefaultValue.defaultCornerRadius
    
    var shape: AnimatableCheckbox.BoxShape = CheckboxDefaultValue.defaultShape
    
    func pathForMark(in rect: CGRect) -> UIBezierPath {
        let size = min(rect.height, rect.width)
        let transform = CGAffineTransform(scaleX: 0.665, y: 0.665)
        let translate = CGAffineTransform(translationX: size * 0.1675, y: size * 0.1675)
        let path = pathForBox(in: rect)
        path.apply(transform)
        path.apply(translate)
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
