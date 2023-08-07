//
//  TertitaryPositionCategoryViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import UIKit
import SwifterSwift

class TertitaryPositionCategoryViewController: UIViewController {
    
    static func instantiate(
        with row: PositionCategorySelectableRow,
        reactor: PositionCategoryReactor,
        reactorDidChange: ((PositionCategoryReactor) -> Void)? = nil
    ) -> TertitaryPositionCategoryViewController {
        let vc = Storyboard.positionCategory.instantiate(TertitaryPositionCategoryViewController.self)
        var data = row.params.child?.map { PositionCategorySelectableRow(params: $0) } ?? []
        if reactor.displayAll {
            data.prepend(PositionCategorySelectableRow(params: row.params))
        }
        vc.dataSource.data = data
        vc.navigationItem.title = row.params.title
        vc.reactor = reactor
        vc.reactorUpdateHandler = reactorDidChange
        return vc
    }
    
    let dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [])
    
    var reactor = PositionCategoryReactor() {
        didSet { self.dataSource.reloadData() }
    }
    
    private var reactorUpdateHandler: ((PositionCategoryReactor) -> Void)?
    
    @IBOutlet weak var collectionView: CollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func bindingUI() {
        
        collectionView.provider = ComposedHeaderProvider(
            headerViewSource: { (view: PositionCategoryViewHeader, data: HeaderData, at: Int) in
                view.populate(data: [], isExpand: false)
            },
            headerSizeSource: { _, _, size in
                return PositionCategoryViewHeader.sizeFor(
                    data: [],
                    isExpand: false,
                    maxWidth: size.width
                )
            },
            sections: [
                BasicProvider(
                    dataSource: dataSource,
                    viewSource: { [weak self] (view: WrapperView<CollectionView>, data: PositionCategorySelectableRow, at: Int) in
                        guard let self else { return }
                        
                        view.contentView.isUserInteractionEnabled = false
                        view.contentView.provider = CompositionProvider(
                            layout: RowLayout("label", alignItems: .center).inset(8)
                        ) {
                            CheckBoxProvider(checked: self.reactor.tertitaryRows.contains(data))
                            SpaceProvider(width: 6)
                            LabelProvider(identifier: "label", text: data.params.code % 100 == 0 ? data.params.title + "全部" : data.params.title, width: .fill)
                        }
                    },
                    sizeSource: { at, data, size in
                        var aSize = CGSize(width: size.width, height: 0)
                        
                        let contentInset = UIEdgeInsets(inset: 8)
                        
                        aSize.height += data.params.title.size(ofFont: .qt_body(), maxWidth: size.width - contentInset.horizontal).height
                        
                        aSize.height += contentInset.vertical
                        
                        return aSize
                    },
                    layout: FlowLayout().inset(left: 20, right: 20),
                    animator: AnimatedReloadAnimator(),
                    tapHandler: { [weak self] context in
                        guard let self else { return }
                        
                        var tertitaryRows: Set<PositionCategorySelectableRow> = []
                        
                        if context.index == 0, self.reactor.displayAll {
                            // all was selected
                            if self.reactor.tertitaryRows.contains(context.data) {
                                tertitaryRows = self.reactor.tertitaryRows.symmetricDifference([context.data])
                            } else {
                                tertitaryRows = self.reactor.tertitaryRows.filter { !$0.isSubsetSubset(of: context.data) }
                                    .symmetricDifference([context.data])
                            }
                            
                        } else {
                            tertitaryRows = self.reactor.tertitaryRows.symmetricDifference([context.data])
                            let subset = tertitaryRows.filter(\.isSecondaryRow).filter { $0.isParent(of: context.data) }
                            tertitaryRows = tertitaryRows.subtracting(subset)
                        }
                        
                        self.reactor.tertitaryRows = tertitaryRows
                        
                        self.reactorUpdateHandler?(self.reactor)
                    }
                )
            ]
        )
    }
}
