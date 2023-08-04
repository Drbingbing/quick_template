//
//  CheckboxState.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/18.
//

import Foundation

extension AnimatableCheckbox {
    
    enum CheckState {
        case unchecked
        case checked
        
        mutating func toggle() {
            switch self {
            case .unchecked:
                self = .checked
            case .checked:
                self = .unchecked
            }
        }
    }
}
