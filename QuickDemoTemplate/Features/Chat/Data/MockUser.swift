//
//  MockUser.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import Foundation

protocol SenderType {
    var senderId: String { get }
    var displayName: String { get }
}

struct MockUser: SenderType, Equatable {
    var senderId: String
    var displayName: String
}
