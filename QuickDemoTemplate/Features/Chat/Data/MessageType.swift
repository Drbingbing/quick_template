//
//  MessageType.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import Foundation

protocol MessageType {
    
    var sender: SenderType { get }
    var messageId: String { get }
    var sentDate: Date { get }
    var kind: MessageKind { get }
}

