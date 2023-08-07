//
//  PositionCategoryReactor.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/4.
//

import Foundation

struct PositionCategoryReactor {
    
    let displayAll: Bool
    var tertitaryRows: Set<CodeJsonParams>
    
    init(displayAll: Bool = false, tertitaryRows: Set<CodeJsonParams> = []) {
        self.displayAll = displayAll
        self.tertitaryRows = tertitaryRows
    }
}
