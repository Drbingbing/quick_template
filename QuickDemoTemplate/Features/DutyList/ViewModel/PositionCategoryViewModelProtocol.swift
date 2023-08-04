//
//  PositionCategoryViewModelProtocol.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import Foundation

protocol PositionCategoryViewModelProtocol {
    var input: PositionCategoryViewModelInput { get }
    var output: PositionCategoryViewModelOutput { get }
}

protocol PositionCategoryViewModelInput {
    func didSelectRow(at atIndex: Int)
    func viewDidLoad()
}

struct PositionCategoryViewModelOutput {
    var data: ([PositionCategorySelectableRow]) -> Void
    var selectRow: (PositionCategorySelectableRow) -> Void
}

class PositionCategoryViewModel: PositionCategoryViewModelProtocol, PositionCategoryViewModelInput {
    
    var input: PositionCategoryViewModelInput { return self }
    var output: PositionCategoryViewModelOutput
    
    init(output: PositionCategoryViewModelOutput) {
        self.output = output
    }
    
    private var data: [PositionCategorySelectableRow] = []
    
    func viewDidLoad() {
        
        output.data(data)
    }
    
    func didSelectRow(at atIndex: Int) {
        
    }
}
