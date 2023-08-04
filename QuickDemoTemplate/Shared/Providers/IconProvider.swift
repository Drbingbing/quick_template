//
//  IconProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/2.
//

import Foundation
import SwifterSwift
import UIKit

class IconProvider: SimpleViewProvider {
    
    enum Alignment {
        case leading
        case trailing
    }
    
    
    init(text: String, icon: String = "icon_arrow_right_8", alignment: Alignment = .trailing) {
        let view = SimpleIconView()
        view.label.text = text
        view.label.font = .qt_body()
        view.label.textColor = .gray1
        view.imageView.image = UIImage(named: icon)
        view.alignment = alignment
        
        super.init(
            identifier: nil,
            views: [view],
            sizeSource: SimpleViewSizeSource(sizeStrategy: (.fill, .fit)),
            layout: FlowLayout()
        )
    }
}

private class SimpleIconView: BaseView {
    
    let label = UILabel()
    let imageView = UIImageView()
    private let stackView = UIStackView()
    
    var alignment: IconProvider.Alignment = .trailing {
        didSet {
            stackView.removeArrangedSubviews()
            switch alignment {
            case .leading:
                stackView.addArrangedSubviews([imageView, label])
            case .trailing:
                stackView.addArrangedSubviews([label, imageView])
            }
        }
    }
    
    override func viewDidLoad() {
        addSubview(stackView)
        stackView.addArrangedSubviews([label, imageView])
        stackView.alignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.frame = bounds
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let a = label.sizeThatFits(size)
        let b = imageView.sizeThatFits(size)
        
        return CGSize(width: a.width + b.width, height: max(a.height, b.height))
    }
}
