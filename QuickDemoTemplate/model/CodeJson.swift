//
//  CodeJson.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import Foundation
import SwiftyJSON

struct CodeJson {
    
    let title: String
    let code: Int
    let child: [CodeJson]?
    
    init(json: JSON) {
        self.init(
            title: json["des"].stringValue,
            code: json["no"].intValue,
            child: json["n"].array?.map { CodeJson(json: $0) }
        )
    }
    
    init(title: String, code: Int, child: [CodeJson]?) {
        self.title = title
        self.code = code
        self.child = child
    }
}
