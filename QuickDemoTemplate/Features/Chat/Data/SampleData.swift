//
//  SampleData.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit

final class SampleData {
    
    static let system = MockUser(senderId: "000000", displayName: "System")
    static let bingbing = MockUser(senderId: "000001", displayName: "Bing Bing")
    static let nathan = MockUser(senderId: "000002", displayName: "Nathan Tanner")
    static let steven = MockUser(senderId: "000003", displayName: "Steven Deutsch")
    static let wu = MockUser(senderId: "000004", displayName: "Wu Zhong")
    
    static var senders: [MockUser] {
        return [SampleData.nathan, SampleData.steven, SampleData.wu]
    }
    
    static func getMessages(count: Int = 20) -> [MockMessage] {
        var messages: [MockMessage] = []
        
        for _ in 0..<count {
            let uniqueID = UUID().uuidString
            let user = SampleData.senders.randomElement()!
            let date = Date().dateAddingRandomTime()
            let randomSentence = Lorem.sentence()
            let message = MockMessage(text: randomSentence, user: user, messageId: uniqueID, date: date)
            messages.append(message)
        }
        
        return messages
    }
}

private extension Date {
    
    func dateAddingRandomTime() -> Date {
        let randomNumber = Int(arc4random_uniform(UInt32(10)))
        if randomNumber % 2 == 0 {
            let date = Calendar.current.date(byAdding: .hour, value: randomNumber, to: self)!
            return date
        } else {
            let randomMinute = Int(arc4random_uniform(UInt32(59)))
            let date = Calendar.current.date(byAdding: .minute, value: randomMinute, to: self)!
            return date
        }
    }
}
