//
//  MessageDataSource.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import Foundation

final class MessageDataSource: DataSource<MessageAttributes> {
    
    let currentSender: SenderType
    
    private var attributes: [MessageAttributes] = [] {
        didSet { setNeedsReload() }
    }
    
    
    init(currentSender: SenderType, data: [MessageType] = []) {
        self.currentSender = currentSender
        self.data = data
    }
    
    var data: [MessageType] = [] {
        didSet {
            attributes = data.map { MessageAttributes(messageType: $0) }
        }
    }
    
    override func identifier(at: Int) -> String {
        return data[at].messageId
    }
    
    override var numberOfItems: Int {
        return attributes.count
    }
    
    override func data(at: Int) -> MessageAttributes {
        return attributes[at]
    }
}
