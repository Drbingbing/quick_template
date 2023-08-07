//
//  PositionCategorySelectableRow.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import Foundation

struct PositionCategorySelectableRow: Hashable {
    
    let params: CodeJsonParams
    
    init(params: CodeJsonParams) {
        self.params = params
    }
}

extension PositionCategorySelectableRow {
    
    func isSubset(of row: PositionCategorySelectableRow) -> Bool {
        if params.code - row.params.code <= 1000, params.code - row.params.code >= 0 {
            return true
        }
        if params.code - row.params.code <= 100, params.code - row.params.code >= 0 {
            return true
        }
        
        return false
    }
    
    var isPrimaryRow: Bool {
        return params.code % 1000 == 0
    }
    
    var isSecondaryRow: Bool {
        return params.code % 100 == 0
    }
    
    var isTertitaryRow: Bool {
        return params.code % 100 != 0
    }
}
