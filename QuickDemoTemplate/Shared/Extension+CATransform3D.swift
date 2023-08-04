//
//  Extension+CATransform3D.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/29.
//

import UIKit

private let defaultPerspective: CGFloat = -1.0 / 500

extension CATransform3D {
    
    static var identity: CATransform3D {
        return CATransform3DIdentity
    }
    
    func rotateX(_ degree: CGFloat) -> CATransform3D {
        CATransform3DRotate(self, degree, 1, 0, 0)
    }
    
    func scaleX(_ scale: CGFloat) -> CATransform3D {
        CATransform3DScale(self, scale, 1, 1)
    }
    
    func scaleY(_ scale: CGFloat) -> CATransform3D {
        CATransform3DScale(self, 1, scale, 1)
    }
    
    func scaleBy(_ scale: CGFloat) -> CATransform3D {
        CATransform3DScale(self, scale, scale, 1)
    }
    
    func translateX(_ value: CGFloat) -> CATransform3D {
        CATransform3DTranslate(self, value, 0, 0)
    }
    
    func translateY(_ value: CGFloat) -> CATransform3D {
        CATransform3DTranslate(self, 0, value, 0)
    }
    
    func translateBy(_ value: CGFloat) -> CATransform3D {
        CATransform3DTranslate(self, value, value, 0)
    }
    
    func perspective(_ m34: CGFloat = defaultPerspective) -> CATransform3D {
        var transform = self
        transform.m34 = m34
        return transform
    }
}
