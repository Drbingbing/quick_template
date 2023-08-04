//
//  Pair.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/26.
//

import Foundation
import SwiftyJSON

struct Pair {
    
    let title: String
    let code: Int
    
    init(title: String, code: Int) {
        self.title = title
        self.code = code
    }
    
    init(json: JSON) {
        self.init(title: json["des"].stringValue, code: json["no"].intValue)
    }
}
