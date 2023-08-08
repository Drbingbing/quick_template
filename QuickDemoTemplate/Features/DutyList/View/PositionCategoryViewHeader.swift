//
//  PositionCategoryViewHeader.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import UIKit
import BaseToolbox

class PositionCategoryViewHeader: BaseView {
    
    let collectionView = CollectionView()
    let searchBar = UISearchBar()
    
    var maxSelectableCount = 0
    
    override func viewDidLoad() {
        addSubview(collectionView)
        backgroundColor = .systemGray6
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "關鍵字搜尋"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    func populate(data: Set<PositionCategorySelectableRow>, isExpand: Bool, onExpand: (() -> Void)? = nil, onDelete: ((PositionCategorySelectableRow) -> Void)? = nil) {
        collectionView.provider = CompositionProvider(
            layout: FlowLayout().inset(left: 16, right: 16)
        ) {
            SimpleViewProvider(views: [searchBar], sizeStrategy: (.fill, .fit))
            CompositionProvider(
                layout: RowLayout("title").inset(left: 8, right: 8)
            ) {
                LabelProvider(identifier: "title", text: "已選取 \(data.count)\(maxSelectableCount > 0 ? "/" + maxSelectableCount.string : "") 項", color: .systemGray4, font: .qt_body(size: 12))
                CompositionProvider(
                    layout: FlowLayout(spacing: 2, alignItems: .center)
                ) {
                    LabelProvider(text: isExpand ? "收合" : "展開", color: .systemGray4, font: .qt_body(size: 12))
                    ImageProvider(name: isExpand ? "polygon_up" : "polygon_down")
                }
                .tappable(onExpand)
            }
            if isExpand {
                CompositionProvider(
                    layout: FlowLayout(spacing: 8).inset(left: 8, right: 8),
                    animator: AnimatedReloadAnimator()
                ) {
                    SpaceProvider(height: 4)
                    for datum in data {
                        // minus.circle.fill
                        GroupedProvider {
                            BadgeProvider(systemName: "minus.circle.fill") {
                                GroupedProvider {
                                    CompositionProvider(
                                        layout: FlowLayout(spacing: 0, alignItems: .center)
                                    ) {
                                        // icon_cross_8
                                        LabelProvider(text: datum.params.title, color: .red2, font: .qt_body(size: 12))
                                    }
                                }
                                .background(UIColor(hexString: "FAE0E4"))
                                .cornerRadius(4)
                                .padding(4)
                            }
                            .badgeSize(width: 10, height: 10)
                            .badgeColor(.red2)
                            .onTap { context in
                                onDelete?(datum)
                            }
                        }
                    }
                    SpaceProvider(height: 4)
                }
            }
        }
    }
    
    static func sizeFor(data: Set<PositionCategorySelectableRow>, isExpand: Bool, maxWidth: CGFloat) -> CGSize {
        let availableWidth = maxWidth - 48
        // search bar height
        var size = CGSize(width: maxWidth, height: 56)
        
        let titleHeight = "已選取 \(data.count)/10 項".size(
            ofFont: .qt_body(size: 12), maxWidth: availableWidth
        ).height
        
        size.height += titleHeight + 4
        
        if isExpand, !data.isEmpty {
            let padding = UIEdgeInsets(4)
            let sizes = data
                .map { $0.params.title.size(ofFont: .qt_body(size: 12), maxWidth: availableWidth)
                .inset(by: -padding) }
            let (totalHeight, lineData) = distributeLines(sizes: sizes, maxWidth: availableWidth)
            for (_, count) in lineData {
                let (_, lineInteritemSpacing) = LayoutHelper.distribute(
                    justifyContent: .start,
                    maxPrimary: 400,
                    totalPrimary: totalHeight,
                    minimunSpacing: 8,
                    numberOfItems: count
                )
                size.height += lineInteritemSpacing
            }
            size.height += totalHeight
            size.height += 4
        }
        
        return size
    }
    
    private static func distributeLines(sizes: [CGSize], maxWidth: CGFloat) -> (totalHeight: CGFloat, lineData: [(lineSize: CGSize, count: Int)]) {
        let interitemSpacing: CGFloat = 8
        var lineData: [(lineSize: CGSize, count: Int)] = []
        var currentLineItemCount = 0
        var currentLineWidth: CGFloat = 0
        var currentLineMaxHeight: CGFloat = 0
        var totalHeight: CGFloat = 0
        for size in sizes {
          if currentLineWidth + size.width > maxWidth, currentLineItemCount != 0 {
            lineData.append((lineSize: CGSize(width: currentLineWidth - CGFloat(currentLineItemCount) * interitemSpacing,
                                              height: currentLineMaxHeight),
                             count: currentLineItemCount))
            totalHeight += currentLineMaxHeight
            currentLineMaxHeight = 0
            currentLineWidth = 0
            currentLineItemCount = 0
          }
          currentLineMaxHeight = max(currentLineMaxHeight, size.height)
          currentLineWidth += size.width + interitemSpacing
          currentLineItemCount += 1
        }
        if currentLineItemCount > 0 {
          lineData.append((lineSize: CGSize(width: currentLineWidth - CGFloat(currentLineItemCount) * interitemSpacing,
                                            height: currentLineMaxHeight),
                           count: currentLineItemCount))
          totalHeight += currentLineMaxHeight
        }
        return (totalHeight, lineData)
    }
}
