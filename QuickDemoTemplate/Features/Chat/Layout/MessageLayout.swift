//
//  MessageLayout.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/5.
//

import UIKit

class MessageLayout: SimpleLayout {
    
    
    override func simpleLayout(context: LayoutContext) -> [CGRect] {
        var frames: [CGRect] = []
        var lastMessage: MessageAttributes?
        var lastFrame: CGRect?
        
        for i in 0..<context.numberOfItems {
            
            let message = context.data(at: i) as! MessageAttributes
            var yHeight: CGFloat = 0
            
            var cellFrame = CGRect(origin: .zero, size: context.size(at: i, collectionSize: context.collectionSize))
            if let lastMessage = lastMessage, let lastFrame = lastFrame {
                
                yHeight = lastFrame.maxY + message.verticalPaddingBetweenMessage(lastMessage)
                
            }
            
            cellFrame.origin.y = yHeight
            
            lastFrame = cellFrame
            lastMessage = message
            
            frames.append(cellFrame)
        }
        
        return frames
    }
}
