//
//  UIEdgeInset.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/5.
//

import UIKit

extension UIEdgeInsets {
    
    var vertical: CGFloat {
        return top + bottom
    }
    
    var horizontal: CGFloat {
        return left + right
    }
}
