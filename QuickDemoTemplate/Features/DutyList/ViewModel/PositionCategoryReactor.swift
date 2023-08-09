//
//  PositionCategoryReactor.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/4.
//

import Foundation

class PositionCategoryReactor {
    
    let displayAll: Bool
    /// 0 is unlimited
    let maxSelectableCount: Int
    let dataSource: [PositionCategorySelectableRow]
    
    var tertitaryRows: Set<PositionCategorySelectableRow>
    var alertNotifications: ((PositionCategoryReactor) -> Void)?
    
    init(displayAll: Bool = false, maxSelectableCount: Int = 0, dataSource: [PositionCategorySelectableRow], tertitaryRows: Set<PositionCategorySelectableRow> = []) {
        self.displayAll = displayAll
        self.tertitaryRows = tertitaryRows
        self.maxSelectableCount = maxSelectableCount
        self.dataSource = dataSource
    }
    
    func didSelectRow(at atIndex: Int, with data: PositionCategorySelectableRow) {
        
        var tertitaryRows: Set<PositionCategorySelectableRow> = []
        
        if atIndex == 0, displayAll, data.isSecondaryRow {
            // all was selected
            if self.tertitaryRows.contains(data) {
                tertitaryRows = self.tertitaryRows.symmetricDifference([data])
            } else {
                tertitaryRows = self.tertitaryRows.filter { !$0.isSubsetSubset(of: data) }
                    .symmetricDifference([data])
            }
            
        } else {
            
            tertitaryRows = self.tertitaryRows.symmetricDifference([data])
            let subset = tertitaryRows.filter(\.isSecondaryRow).filter { $0.isParent(of: data) }
            tertitaryRows = tertitaryRows.subtracting(subset)
        }
        
        if tertitaryRows.count > maxSelectableCount {
            tertitaryRows.remove(data)
            alertNotifications?(self)
        }
        
        self.tertitaryRows = tertitaryRows
    }
    
    func removeAllTertitaryRows() {
        self.tertitaryRows = []
    }
    
    func removeTertitaryRow(_ row: PositionCategorySelectableRow) {
        tertitaryRows.remove(row)
    }
}
