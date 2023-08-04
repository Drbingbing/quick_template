//
//  CheckBoxDisplayableView.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/18.
//

import UIKit

protocol CheckBoxDisplayableView: UIView {
    var engine: CheckboxEngine { get }
}

extension CheckBoxDisplayableView {
    
    var boxLineWidth: CGFloat {
        get { engine.boxLineWidth }
        set { engine.boxLineWidth = newValue }
    }
    
    var markLineWidth: CGFloat {
        get { engine.markLineWidth }
        set { engine.markLineWidth = newValue }
    }
    
    var colorTheme: CheckboxColorTheme {
        get { engine.colorTheme }
        set { engine.colorTheme = newValue }
    }
    
    var animation: AnimatableCheckbox.Animation {
        get { engine.animation }
        set { engine.animation = newValue }
    }
    
    var state: AnimatableCheckbox.CheckState {
        get { engine.state }
        set { engine.state = newValue }
    }
    
    var shape: AnimatableCheckbox.BoxShape {
        get { engine.boxShape }
        set { engine.boxShape = newValue }
    }
    
    var mark: AnimatableCheckbox.MarkShape {
        get { engine.markShape }
        set { engine.markShape = newValue }
    }
    
    func toggle() {
        engine.state.toggle()
    }
    
    func onTap(action: (() -> Void)? = nil) {
        engine.tapHandler = action
    }
}
