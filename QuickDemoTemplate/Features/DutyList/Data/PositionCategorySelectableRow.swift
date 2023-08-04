//
//  PositionCategorySelectableRow.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import Foundation

struct PositionCategorySelectableRow: Hashable {
    
    let params: CodeJsonParams
    let primaryParams: CodeJsonParams?
    let secondaryParams: CodeJsonParams?
    
    init(params: CodeJsonParams, primaryParams: CodeJsonParams? = nil, secondaryParams: CodeJsonParams? = nil) {
        self.params = params
        self.primaryParams = primaryParams
        self.secondaryParams = secondaryParams
    }
}
