//
//  CheckboxEngine.swift
//  AnimatableCheckBox
//
//  Created by Bing Bing on 2022/10/12.
//

import UIKit

protocol CheckboxRenderNode {
    func apply(path: CheckboxPathGenerator)
    func apply(theme: CheckboxColorTheme)
    func apply(animation: AnimatableCheckbox.Animation)
    func transformShape(from fromShape: AnimatableCheckbox.BoxShape, to toShape: AnimatableCheckbox.BoxShape)
    func transformMark(from fromMark: AnimatableCheckbox.MarkShape, to toMark: AnimatableCheckbox.MarkShape)
    func makeView() -> CAShapeLayer
    func updateView(in rect: CGRect)
    func animate(from fromState: AnimatableCheckbox.CheckState, to toState: AnimatableCheckbox.CheckState)
}

extension CheckboxRenderNode {
    func transformShape(from fromShape: AnimatableCheckbox.BoxShape, to toShape: AnimatableCheckbox.BoxShape) { }
    func transformMark(from fromMark: AnimatableCheckbox.MarkShape, to toMark: AnimatableCheckbox.MarkShape) { }
}

class CheckboxEngine {
    
    weak var view: CheckBoxDisplayableView?
    
    var tapHandler: (() -> Void)? = nil {
        didSet {
            guard tapHandler != nil else { return }
            view?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTap)))
        }
    }
    
    var state: AnimatableCheckbox.CheckState = CheckboxDefaultValue.defaultState {
        didSet {
            guard oldValue != state else { return }
            for node in renderNode {
                node.animate(from: oldValue, to: state)
            }
        }
    }
    
    private var pathGenerator: CheckboxPathGenerator = TickPathGenerator()
    
    var colorTheme: CheckboxColorTheme = CheckboxColorTheme() {
        didSet {
            for node in renderNode {
                node.apply(theme: colorTheme)
            }
        }
    }
    
    var boxShape: AnimatableCheckbox.BoxShape = CheckboxDefaultValue.defaultShape {
        didSet {
            for node in renderNode {
                node.transformShape(from: oldValue, to: boxShape)
            }
        }
    }
    
    var markShape: AnimatableCheckbox.MarkShape = CheckboxDefaultValue.defaultMark {
        didSet {
            for node in renderNode {
                node.transformMark(from: oldValue, to: markShape)
            }
        }
    }
    
    var animation: AnimatableCheckbox.Animation = CheckboxDefaultValue.defaultAnimation {
        didSet {
            for node in renderNode {
                node.apply(animation: animation)
            }
        }
    }
    
    var boxLineWidth: CGFloat {
        get { pathGenerator.boxLineWidth }
        set {
            pathGenerator.boxLineWidth = newValue
            for node in renderNode {
                node.apply(path: pathGenerator)
            }
        }
    }
    
    var markLineWidth: CGFloat {
        get { pathGenerator.markLineWidth }
        set {
            pathGenerator.markLineWidth = newValue
            for node in renderNode {
                node.apply(path: pathGenerator)
            }
        }
    }
    
    var bounds: CGRect {
        guard let view = view else { return .zero }
        return view.bounds
    }
    
    init(view: CheckBoxDisplayableView? = nil) {
        self.view = view
    }
    
    var animator: CheckboxAnimater = CheckboxAnimater()
    
    var renderNode: [CheckboxRenderNode] = [
        UnSelectBoxRenderNode(),
        SelectBoxRenderNode(),
        MarkerRenderNode()
    ]
    
    func setup() {
        for node in renderNode {
            node.apply(path: pathGenerator)
            let layer = node.makeView()
            view?.layer.addSublayer(layer)
        }
    }
    
    func layoutSubview() {
        for node in renderNode {
            node.updateView(in: bounds)
        }
    }
    
    @objc
    private func didTap(_ sender: UITapGestureRecognizer) {
        tapHandler?()
    }
}
