//
//  MockMessage.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import Foundation

struct MockMessage: MessageType {
    
    let messageId: String
    let sender: SenderType
    let sentDate: Date
    let kind: MessageKind
    
    private init(kind: MessageKind, user: MockUser, messageId: String, date: Date) {
        self.messageId = messageId
        self.kind = kind
        sentDate = date
        sender = user
    }
    
    init(text: String, user: MockUser, messageId: String, date: Date) {
        self.init(kind: .text(text), user: user, messageId: messageId, date: date)
    }
}
