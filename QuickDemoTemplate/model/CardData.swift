//
//  CardData.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/29.
//

import UIKit

struct CardData {
    
    let id = UUID().uuidString
    let color: UIColor
    
    static let system: [CardData] = [
        CardData(color: .systemRed),
        CardData(color: .systemBlue),
        CardData(color: .systemCyan),
        CardData(color: .systemGray),
        CardData(color: .systemMint),
        CardData(color: .systemPink),
        CardData(color: .systemTeal),
        CardData(color: .systemBrown),
        CardData(color: .systemGray2),
        CardData(color: .systemIndigo),
        CardData(color: .systemGreen),
        CardData(color: .systemOrange),
        CardData(color: .systemPurple),
        CardData(color: .systemYellow)
    ]
     
    static func take(_ amount: Int) -> [CardData] {
        return CardData.system.shuffled().suffix(amount)
    }
}
