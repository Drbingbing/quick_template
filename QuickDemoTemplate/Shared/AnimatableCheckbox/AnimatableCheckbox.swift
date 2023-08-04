//
//  AnimatableCheckbox.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/7.
//

import UIKit

class AnimatableCheckbox: UIView, CheckBoxDisplayableView {
    
    lazy var engine = CheckboxEngine(view: self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        engine.setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        engine.setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        engine.layoutSubview()
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: 20, height: 20)
    }
}

extension AnimatableCheckbox {
    
    enum NavigationStyle {
        case apply
        case close
    }
    
    func style(for navigation: NavigationStyle, foregroundColor: UIColor) {
        switch navigation {
        case .apply:
            animation = .stroke
            boxLineWidth = 0
            mark = .tick
            colorTheme.markColor = foregroundColor
            state = .checked
        case .close:
            animation = .stroke
            boxLineWidth = 0
            mark = .cross
            colorTheme.markColor = foregroundColor
            state = .checked
        }
    }
    
    static func navigationStyle(foregroundColor: UIColor = .gray1, for style: AnimatableCheckbox.NavigationStyle) -> AnimatableCheckbox {
        let view = AnimatableCheckbox()
        view.style(for: style, foregroundColor: foregroundColor)
        view.frame = CGRect(origin: .zero, size: CGSize(width: 26, height: 26))
        return view
    }
}
