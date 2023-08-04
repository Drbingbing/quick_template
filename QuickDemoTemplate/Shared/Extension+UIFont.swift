//
//  Extension+UIFont.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/27.
//

import UIKit

extension UIFont {
    
    public var bolded: UIFont {
        return self.fontDescriptor.withSymbolicTraits(.traitBold)
            .map { UIFont(descriptor: $0, size: 0.0) } ?? self
    }
    
    public static func qt_body(size: CGFloat? = 14) -> UIFont {
        return .preferredFont(style: .body, size: size)
    }
    
    public static var qt_title: UIFont {
        return preferredFont(style: .title1, size: 32)
    }
    
    fileprivate static func preferredFont(style: UIFont.TextStyle, size: CGFloat? = nil) -> UIFont {
        let defaultSize: CGFloat
        switch style {
        case UIFont.TextStyle.body: defaultSize = 17
        case UIFont.TextStyle.callout: defaultSize = 16
        case UIFont.TextStyle.caption1: defaultSize = 12
        case UIFont.TextStyle.caption2: defaultSize = 11
        case UIFont.TextStyle.footnote: defaultSize = 13
        case UIFont.TextStyle.headline: defaultSize = 17
        case UIFont.TextStyle.subheadline: defaultSize = 15
        case UIFont.TextStyle.title1: defaultSize = 28
        case UIFont.TextStyle.title2: defaultSize = 22
        case UIFont.TextStyle.title3: defaultSize = 20
        default: defaultSize = 17
        }
        
        let font: UIFont
        if #available(iOS 13.0, *) {
            font = UIFont.preferredFont(
                forTextStyle: style,
                compatibleWith: .current
            )
        } else {
            font = UIFont.preferredFont(forTextStyle: style)
        }
        let descriptor = font.fontDescriptor.withDesign(.rounded) ?? font.fontDescriptor
        return UIFont(
            descriptor: descriptor,
            size: ceil(font.pointSize / defaultSize * (size ?? defaultSize))
        )
    }
}
