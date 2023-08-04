//
//  PositionCategoryParams.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import Foundation
import SwiftyJSON

struct CodeJsonParams: Hashable {
    
    let title: String
    let code: Int
    let child: [CodeJsonParams]?
    
    init(json: JSON) {
        self.init(
            title: json["des"].stringValue,
            code: json["no"].intValue,
            child: json["n"].array?.map { CodeJsonParams(json: $0) }
        )
    }
    
    init(title: String, code: Int, child: [CodeJsonParams]?) {
        self.title = title
        self.code = code
        self.child = child
    }
}
