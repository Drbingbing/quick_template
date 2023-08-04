//
//  Extension+Provider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/28.
//

import UIKit

extension Provider {
    
    @discardableResult
    func tappable(_ onTap: (() -> Void)?) -> Provider {
        return GroupedProvider { self }
            .tappable(onTap)
    }
}
