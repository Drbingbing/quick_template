//
//  Extension+SpaceProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit

extension SpaceProvider {
    
    convenience init(height: CGFloat) {
        self.init(sizeStrategy: (.fill, .absolute(height)))
    }
    
    convenience init(width: CGFloat) {
        self.init(sizeStrategy: (.absolute(width), .absolute(1)))
    }
}
