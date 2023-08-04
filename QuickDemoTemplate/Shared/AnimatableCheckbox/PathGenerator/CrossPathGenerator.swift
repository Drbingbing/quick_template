//
//  CrossPathGenerator.swift
//  Recruit
//
//  Created by Bing Bing on 2022/12/15.
//  Copyright © 2022 Daniel. All rights reserved.
//

import UIKit

class CrosPathGenerator: CheckboxPathGenerator {
    
    var boxLineWidth: CGFloat = CheckboxDefaultValue.defaultBoxLineWidth
    var markLineWidth: CGFloat = CheckboxDefaultValue.defaultMarkLineWidth
    var cornerRadius: CGFloat = CheckboxDefaultValue.defaultCornerRadius
    
    var shape: AnimatableCheckbox.BoxShape = CheckboxDefaultValue.defaultShape
    
    func pathForBox(in rect: CGRect) -> UIBezierPath {
        switch shape {
        case .square:
            return squarePath(in: rect)
        case .circle:
            return circlePath(in: rect)
        }
    }
    
    func pathForMark(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        
        let tl = CGPoint(x: rect.width / 3, y: rect.height / 3)
        let tr = CGPoint(x: rect.maxX - rect.width / 3, y: rect.height / 3)
        
        let bl = CGPoint(x: rect.width / 3, y: rect.maxY - rect.height / 3)
        let br = CGPoint(x: rect.maxX - rect.width / 3, y: rect.maxY - rect.height / 3)
        
        path.move(to: tl)
        path.addLine(to: br)
        path.move(to: tr)
        path.addLine(to: bl)
        
        return path
    }
}
