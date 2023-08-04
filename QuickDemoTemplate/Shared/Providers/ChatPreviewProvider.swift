//
//  ChatPreviewProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/3.
//

import UIKit

class ChatPreviewProvider: SimpleViewProvider {
    
    init() {
        
        let collectionView = CollectionView()
        collectionView.provider = ComposedProvider(
            layout: FlowLayout(spacing: 4),
            sections: [
                ComposedProvider(
                    layout: FlowLayout(spacing: 4, justifyContent: .start, alignItems: .center),
                    sections: [
                        ImageProvider(
                            systemName: "person.fill",
                            width: 8,
                            height: 8,
                            inset: UIEdgeInsets(4)
                        ).background(.red3).cornerRadius(8).foregroundColor(.gray1),
                        LabelProvider(
                            text: "hello",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.red3).cornerRadius(4)
                    ]
                ),
                ComposedProvider(
                    layout: FlowLayout(spacing: 4, justifyContent: .end, alignItems: .center),
                    sections: [
                        LabelProvider(
                            text: "Hi.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4)
                    ]
                ),
                ComposedProvider(
                    layout: FlowLayout(spacing: 4, justifyContent: .start, alignItems: .center),
                    sections: [
                        ImageProvider(
                            systemName: "person.fill",
                            width: 8,
                            height: 8,
                            inset: UIEdgeInsets(4)
                        ).background(.red3).cornerRadius(8).foregroundColor(.gray1),
                        LabelProvider(
                            text: "How high are you?",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.red3).cornerRadius(4)
                    ]
                ),
                ComposedProvider(
                    layout: FlowLayout(spacing: 2, justifyContent: .end, alignItems: .center),
                    sections: [
                        LabelProvider(
                            text: "I'm really, really high.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4),
                        LabelProvider(
                            text: "About 35,000 feet high, to be exact.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4),
                        LabelProvider(
                            text: "Right now, I’m on a flight to Hawaii, where I’m going for spring break.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4)
                    ]
                ),
                ComposedProvider(
                    layout: FlowLayout(spacing: 4, justifyContent: .start, alignItems: .center),
                    sections: [
                        ImageProvider(
                            systemName: "person.fill",
                            width: 8,
                            height: 8,
                            inset: UIEdgeInsets(4)
                        ).background(.red3).cornerRadius(8).foregroundColor(.gray1),
                        LabelProvider(
                            text: "uh?",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.red3).cornerRadius(4)
                    ]
                ),
                ComposedProvider(
                    layout: FlowLayout(spacing: 4, justifyContent: .end, alignItems: .center),
                    sections: [
                        LabelProvider(
                            text: "It’s a 7 hour flight, and I have about 4 to go.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4),
                        LabelProvider(
                            text: "I’m super bored, and my ass keeps cramping up.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4),
                        LabelProvider(
                            text: "I can’t wait until we land.",
                            color: .gray1,
                            font: .qt_body(size: 8),
                            inset: UIEdgeInsets(4)
                        ).alignment(.right).background(.systemGray6.withAlphaComponent(0.5)).cornerRadius(4),
                    ]
                )
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
