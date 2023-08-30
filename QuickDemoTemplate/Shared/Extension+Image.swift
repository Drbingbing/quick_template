//
//  Extension+Image.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/30.
//

import UIKit
import UIComponent

extension Image {
    
    init(_ icon: String, renderingMode: UIImage.RenderingMode) {
#if DEBUG
        if let image = UIImage(named: icon) {
            self.init(image.withRenderingMode(renderingMode))
        } else {
            let error = "Image should be initialized with a valid image name. Image named \(icon) not found."
            assertionFailure(error)
            self.init(UIImage())
        }
#else
        self.init(UIImage(named: icon)?.withRenderingMode(renderingMode) ?? UIImage())
#endif
       
    }
}
