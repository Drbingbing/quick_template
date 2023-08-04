//
//  PathGenerator.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/17.
//

import UIKit

protocol CheckboxPathGenerator {
    
    var boxLineWidth: CGFloat { get set }
    
    var markLineWidth: CGFloat { get set }
    
    var cornerRadius: CGFloat { get set }
    
    var shape: AnimatableCheckbox.BoxShape { get set }
    
    func pathForBox(in rect: CGRect) -> UIBezierPath
    
    func pathForMark(in rect: CGRect) -> UIBezierPath
}

extension CheckboxPathGenerator {
    
    func squarePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let size = min(rect.width, rect.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let startX = center.x
        let startY = center.y - size / 2

        let tr = CGPoint(x: startX + size / 2, y: startY)
        let br = CGPoint(x: startX + size / 2, y: startY + size)
        let bl = CGPoint(x: startX - size / 2, y: startY + size)
        let tl = CGPoint(x: startX - size / 2, y: startY)

        path.move(to: CGPoint(x: startX, y: startY))

        path.addLine(to: CGPoint(x: tr.x - cornerRadius, y: startY))
        if cornerRadius > 0 {
            path.addQuadCurve(to: CGPoint(x: tr.x, y: tr.y + cornerRadius), controlPoint: tr)
        }
        path.addLine(to: CGPoint(x: startX + size / 2, y: tr.y + cornerRadius))
        path.addLine(to: CGPoint(x: br.x, y: br.y - cornerRadius))
        if cornerRadius > 0 {
            path.addQuadCurve(to: CGPoint(x: br.x - cornerRadius, y: br.y), controlPoint: br)
        }
        path.addLine(to: CGPoint(x: startX, y: startY + size))
        path.addLine(to: CGPoint(x: bl.x + cornerRadius, y: bl.y))
        if cornerRadius > 0 {
            path.addQuadCurve(to: CGPoint(x: bl.x, y: bl.y - cornerRadius), controlPoint: bl)
        }
        path.addLine(to: CGPoint(x: startX - size / 2, y: startY + size / 2))
        path.addLine(to: CGPoint(x: tl.x, y: tl.y + cornerRadius))
        if cornerRadius > 0 {
            path.addQuadCurve(to: CGPoint(x: tl.x + cornerRadius, y: tl.y), controlPoint: tl)
        }
        path.addLine(to: CGPoint(x: startX, y: startY))
        
        return path
    }
    
    func circlePath(in rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let size = min(rect.width, rect.height)
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = (size - boxLineWidth) / 2.0

        let unit = 3
        for i in 0..<unit {
            let startAngle = -CGFloat.pi / 2 + CGFloat.pi / CGFloat(unit) * CGFloat(i)
            let endAngle = -CGFloat.pi / 2 + CGFloat.pi / CGFloat(unit) * CGFloat(i + 1)
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        }

        for i in 0..<unit {
            let startAngle = CGFloat.pi / 2 + CGFloat.pi / CGFloat(unit) * CGFloat(i)
            let endAngle = CGFloat.pi / 2 + CGFloat.pi / CGFloat(unit) * CGFloat(i + 1)
            path.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        }
        
        return path
    }
}
