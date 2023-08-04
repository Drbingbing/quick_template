//
//  AvatorPosition.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/6.
//

import Foundation

struct AvatorPosition {
    
    enum Horizontal {
        case cellLeading
        case cellTrailing
        case hidden
        
        /// Positions the `AvatarView` based on whether the message is from the current Sender.
        /// The cell is `not display` if `isFromCurrentSender` is true
        /// and `.cellLeading` if false.
        case natural
    }
    
    enum Vertical {
        case cellTop
        case cellBottom
    }
    
    var vertical: Vertical
    var horizontal: Horizontal
    
    init(vertical: Vertical, horizontal: Horizontal = .natural) {
        self.vertical = vertical
        self.horizontal = horizontal
    }
}
