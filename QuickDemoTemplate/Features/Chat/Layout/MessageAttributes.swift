//
//  MessageAttributes.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/4.
//

import UIKit

class MessageAttributes {
    
    let messageType: MessageType
    
    var avatorPosition = AvatorPosition(vertical: .cellTop, horizontal: .cellLeading)
    var avatorSize = CGSize.zero
    var messageContainerSize = CGSize.zero
    var messageContainerPadding = UIEdgeInsets.zero
    var messageLabelFont = UIFont.qt_body()
    var messageLabelInsets = UIEdgeInsets.zero
    var messageContentInset = UIEdgeInsets.zero
    
    var displayNameFont = UIFont.qt_body(size: 12)
    var displayNameSize = CGSize.zero
    
    var frame = CGRect.zero
    
    init(messageType: MessageType) {
        self.messageType = messageType
    }
    
    func verticalPaddingBetweenMessage(_ previousMessageAttribute: MessageAttributes) -> CGFloat {
        if messageType.sender.senderId == previousMessageAttribute.messageType.sender.senderId {
            return 4
        }
        return 12
    }
}
