//
//  TextMessageView.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/17.
//

import UIKit

final class TextMessageView: BaseView {
    
    let messageLabel = WrapperView<UILabel>()
    let containerView = MessageContainerView()
    let displayNameLabel = WrapperView<UILabel>()
    let avatorView = AvatorView()
    
    func populate(text: String, name: String) {
        messageLabel.contentView.text = text
        displayNameLabel.contentView.text = name
    }
    
    func apply(attribute: MessageAttributes) {
        layoutAvatorView(with: attribute)
        layoutDisplayNameLabel(with: attribute)
        layoutContainerView(with: attribute)
        
        containerView.style = .bubbleTailOutlined(attribute.avatorPosition.horizontal == .cellLeading ? .topLeft : .topRight)
        containerView.tintColor = attribute.avatorPosition.horizontal == .cellLeading ? .green2 : .green1
        messageLabel.inset = attribute.messageLabelInsets
        messageLabel.contentView.font = attribute.messageLabelFont
        
        displayNameLabel.contentView.font = attribute.displayNameFont
    }
    
    override func viewDidLoad() {
        addSubview(displayNameLabel)
        addSubview(containerView)
        addSubview(avatorView)
        
        displayNameLabel.contentView.textColor = .gray1
        
        avatorView.image = UIImage(named: "cute_snow_white")
        avatorView.inset = UIEdgeInsets(6)
        avatorView.cornerRadius(15)
        
        messageLabel.contentView.textColor = .gray1
        messageLabel.contentView.numberOfLines = 0
        containerView.addSubview(messageLabel)
        
        containerView.clipsToBounds = true
        containerView.layer.masksToBounds = true
//        containerView.layer.shadowOffset = CGSize(width: 0, height: 1)
//        containerView.layer.shadowColor = UIColor.systemFill.cgColor
//        containerView.layer.shadowRadius = 2
//        containerView.layer.shadowOpacity = 0.5
    }
    
    private func layoutAvatorView(with attribute: MessageAttributes) {
        var origin = CGPoint.zero
        
        switch attribute.avatorPosition.horizontal {
        case .cellLeading:
            origin.x = attribute.messageContentInset.left
        case .cellTrailing:
            origin.x = attribute.frame.width - attribute.avatorSize.width
        case .hidden:
            origin.x = attribute.frame.width
        case .natural:
            fatalError("AvatarPositionUnresolved")
        }
        
        switch attribute.avatorPosition.vertical {
        case .cellBottom:
            origin.y = attribute.frame.height - attribute.avatorSize.height - attribute.messageContentInset.bottom
        case .cellTop:
            origin.y = attribute.messageContentInset.top
        }
        
        avatorView.frame = CGRect(origin: origin, size: attribute.avatorSize)
    }
    
    private func layoutDisplayNameLabel(with attribute: MessageAttributes) {
        var origin = CGPoint.zero
        
        switch attribute.avatorPosition.horizontal {
        case .cellLeading:
            origin.x = avatorView.frame.maxX
        case .cellTrailing:
            origin.x = avatorView.frame.minX - attribute.displayNameSize.width
        case .hidden:
            origin.x = avatorView.frame.minX - attribute.displayNameSize.width - attribute.messageContentInset.right
        case .natural:
            break
        }
        
        displayNameLabel.frame = CGRect(origin: origin, size: attribute.displayNameSize)
    }
    
    private func layoutContainerView(with attribute: MessageAttributes) {
        var origin = CGPoint.zero
        
        switch attribute.avatorPosition.horizontal {
        case .cellLeading:
            origin.x = avatorView.frame.maxX
        case .cellTrailing:
            origin.x = avatorView.frame.minX - attribute.messageContainerSize.width
        case .hidden:
            origin.x = attribute.frame.width - attribute.messageContainerSize.width - attribute.messageContentInset.right
        case .natural:
            fatalError("AvatarPositionUnresolved")
        }
        
        origin.y = displayNameLabel.frame.maxY
        
        containerView.frame.origin = origin
        containerView.frame.size = attribute.messageContainerSize
        messageLabel.frame = containerView.bounds
    }
}

