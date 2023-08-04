//
//  ResumePreviewProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/17.
//

import Foundation

class ResumePreviewProvider: SimpleViewProvider {
    
    init() {
        let collectionView = CollectionView()
        collectionView.provider = ComposedProvider(
            layout: FlowLayout(spacing: 4),
            sections: [
                SpaceProvider(height: 200)
            ]
        )
        
        super.init(
            identifier: nil,
            views: [collectionView],
            sizeSource: SimpleViewSizeSource(sizeStrategy: (.fill, .fit)),
            layout: FlowLayout()
        )
    }
}
