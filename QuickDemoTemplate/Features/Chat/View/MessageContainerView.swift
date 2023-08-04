//
//  MessageContainerView.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/14.
//

import UIKit

enum MessageContainerStyle {
    
    case bubbleTailOutlined(TailCorner)
    
    enum TailCorner {
        case topLeft
        case bottomLeft
        case topRight
        case bottomRight

        internal var imageOrientation: UIImage.Orientation {
          switch self {
          case .bottomRight: return .up
          case .bottomLeft: return .upMirrored
          case .topLeft: return .down
          case .topRight: return .downMirrored
          }
        }
    }
    
    private var imageName: String {
        switch self {
        case .bubbleTailOutlined:
            return "bubble_full_tail_v2"
        }
    }
    
    private func stretch(_ image: UIImage) -> UIImage {
      let center = CGPoint(x: image.size.width / 2, y: image.size.height / 2)
      let capInsets = UIEdgeInsets(top: center.y, left: center.x, bottom: center.y, right: center.x)
      return image.resizableImage(withCapInsets: capInsets, resizingMode: .stretch)
    }
    
    var image: UIImage? {
        guard var image = UIImage(named: imageName) else { return nil }
        switch self {
        case .bubbleTailOutlined(let tailCorner):
            guard let cgImage = image.cgImage else { return nil }
            image = UIImage(cgImage: cgImage, scale: image.scale, orientation: tailCorner.imageOrientation)
            return stretch(image)
        }
    }
}

class MessageContainerView: UIImageView {
    
    var style: MessageContainerStyle = .bubbleTailOutlined(.topLeft) {
        didSet { applyMessageStyle() }
    }
    
    private let imageMask = UIImageView()
    
    override var frame: CGRect {
        didSet { updateMaskView() }
    }
    
    private func updateMaskView() {
        imageMask.frame = bounds
    }
    
    private func applyMessageStyle() {
        switch style {
        case let .bubbleTailOutlined(tail):
            let bubbleStyle: MessageContainerStyle = .bubbleTailOutlined(tail)
            imageMask.image = bubbleStyle.image
            updateMaskView()
            mask = imageMask
            image = style.image?.withRenderingMode(.alwaysTemplate)
        }
    }
}
