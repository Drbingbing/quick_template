//
//  CheckboxDefaultValue.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/19.
//

import Foundation

struct CheckboxDefaultValue {
    
    static let defaultState = AnimatableCheckbox.CheckState.unchecked
    static let defaultAnimation = AnimatableCheckbox.Animation.stroke
    static let defaultPath: CheckboxPathGenerator = TickPathGenerator()
    static let defaultTheme = CheckboxColorTheme()
    static let defaultShape = AnimatableCheckbox.BoxShape.circle
    static let defaultMark = AnimatableCheckbox.MarkShape.tick
    
    static let defaultBoxLineWidth: CGFloat = 1.5
    static let defaultMarkLineWidth: CGFloat = 1.5
    static let defaultCornerRadius: CGFloat = 3
    
    static let defaultAnimationDuration: Double = 0.2
}
