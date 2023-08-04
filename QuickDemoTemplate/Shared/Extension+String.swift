//
//  Extension+String.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit

extension String {
    
    func size(ofFont font: UIFont, maxWidth: CGFloat, padding: UIEdgeInsets = .zero) -> CGSize {
        let maxSize = CGSize(width: maxWidth, height: 0)
        var rect = self.boundingRect(
            with: maxSize,
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font ], context: nil
        )
        rect.size = CGSize(
            width: ceil(rect.size.width) + padding.left + padding.right,
            height: ceil(rect.size.height) + padding.bottom + padding.top)
        return rect.size
    }
}
