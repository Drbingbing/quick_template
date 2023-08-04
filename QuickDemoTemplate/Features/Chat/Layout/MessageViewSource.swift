//
//  MessageViewSource.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit
import BaseToolbox

final class MessageViewSource: ViewSource<MessageAttributes, TextMessageView> {
    
    override func update(view: TextMessageView, data: MessageAttributes, index: Int) {
        switch data.messageType.kind {
        case let .text(text):
            view.apply(attribute: data)
            view.populate(text: text, name: data.messageType.sender.displayName)
        }
    }
    
    override func view(data: MessageAttributes, index: Int) -> TextMessageView {
        switch data.messageType.kind {
        case .text:
            let view = reuseManager.dequeue(TextMessageView())
            update(view: view, data: data, index: index)
            return view
        }
    }
}
