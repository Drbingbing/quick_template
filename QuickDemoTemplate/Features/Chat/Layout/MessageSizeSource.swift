//
//  MessageSizeSource.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit
import BaseToolbox

protocol MessageSizeSourceDelegate: AnyObject {
    
    func isFromCurrentSender(for message: MessageType) -> Bool
}

class MessageSizeSource: SizeSource<MessageAttributes> {
    
    weak var delegate: MessageSizeSourceDelegate?
    
    init(delegate: MessageSizeSourceDelegate? = nil) {
        self.delegate = delegate
    }
    
    private let messageLabelFont = UIFont.qt_body()
    private let avatorSize = CGSize(width: 40, height: 40)
    private let spacingOfAvatorAndMessageContainer: CGFloat = 4
    private let messageContainerPadding = UIEdgeInsets(left: 30, right: 4)
    private let messageContentInset = UIEdgeInsets(left: 0, right: 8)
     
    override func size(at index: Int, data: MessageAttributes, collectionSize: CGSize) -> CGSize {
        let messageContainerHeight = messageContainerSize(for: data, itemWidth: collectionSize.width).height
        let avatarHeight = avatorSize(for: data).height
        let messageVerticalPadding = messageContainerPadding(for: data).vertical
        let messageContentInsetHeight = messageContentInsets(for: data).vertical
        
        data.avatorPosition = avatorPosition(for: data)
        
        var contentHeight: CGFloat = 0
        let labelsHeight = messageContainerHeight + messageVerticalPadding
        contentHeight += max(labelsHeight, avatarHeight)
        contentHeight += messageContentInsetHeight
        
        contentHeight += topLabelSize(for: data, itemWidth: collectionSize.width)
        
        data.frame.size = CGSize(width: collectionSize.width, height: contentHeight)
        
        return CGSize(width: collectionSize.width, height: contentHeight)
    }
    
    private func topLabelSize(for message: MessageAttributes, itemWidth: CGFloat) -> CGFloat {
        let maxWidth = messageContainerMaxWidth(for: message, itemWidth: itemWidth)
        let displayName = message.messageType.sender.displayName
        let displaySize = displayName.size(ofFont: message.displayNameFont, maxWidth: maxWidth)
        message.displayNameSize = displaySize
        return displaySize.height
    }
    
    private func messageContainerSize(for message: MessageAttributes, itemWidth: CGFloat) -> CGSize {
        let maxWidth = messageContainerMaxWidth(for: message, itemWidth: itemWidth)
        
        var messageContainerSize: CGSize
        let attributeText: NSAttributedString
        
        switch message.messageType.kind {
        case let .text(text):
            attributeText = NSAttributedString(string: text, attributes: [.font: messageLabelFont])
            message.messageLabelFont = messageLabelFont
        }
        
        messageContainerSize = labelSize(for: attributeText, considering: maxWidth)
        
        let messageInsets = messageLabelInsets(for: message)
        messageContainerSize.width += messageInsets.horizontal
        messageContainerSize.height += messageInsets.vertical
        message.messageContainerSize = messageContainerSize
        
        return messageContainerSize
    }
    
    private func messageContainerMaxWidth(for message: MessageAttributes, itemWidth: CGFloat) -> CGFloat {
        let avatorWidth = avatorSize(for: message).width
        let messagePadding = messageContainerPadding(for: message)
        let messageContentInset = messageContentInsets(for: message)
        
        return itemWidth - avatorWidth - messagePadding.horizontal - messageContentInset.horizontal
    }
    
    private func avatorSize(for message: MessageAttributes) -> CGSize {
        message.avatorSize = avatorSize
        return avatorSize
    }
    
    private func messageContainerPadding(for message: MessageAttributes) -> UIEdgeInsets {
        message.messageContainerPadding = messageContainerPadding
        return messageContainerPadding
    }
    
    private func labelSize(for attributedText: NSAttributedString, considering maxWidth: CGFloat) -> CGSize {
        let constraintBox = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
        let rect = attributedText.boundingRect(
          with: constraintBox,
          options: [.usesLineFragmentOrigin, .usesFontLeading],
          context: nil).integral

        return rect.size
    }
    
    private func messageLabelInsets(for message: MessageAttributes) -> UIEdgeInsets {
        message.messageLabelInsets = message.avatorPosition.horizontal == .cellLeading
            ? UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 12) : UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 16)
        return message.messageLabelInsets
    }
    
    private func messageContentInsets(for message: MessageAttributes) -> UIEdgeInsets {
        message.messageContentInset = messageContentInset
        return messageContentInset
    }
    
    private func avatorPosition(for message: MessageAttributes) -> AvatorPosition {
        let isFromCurrentSender = delegate?.isFromCurrentSender(for: message.messageType) ?? false
        var position = AvatorPosition(vertical: .cellTop)
        
        switch position.horizontal {
        case .cellLeading, .cellTrailing, .hidden:
            break
        case .natural:
            position.horizontal = isFromCurrentSender ? .hidden : .cellLeading
        }
        
        return position
    }
}
