//
//  TertitaryPositionCategoryViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import UIKit

class TertitaryPositionCategoryViewController: UIViewController {
    
    static func instantiate(
        with row: PositionCategorySelectableRow,
        reactor: PositionCategoryReactor,
        reactorDidChange: ((PositionCategoryReactor) -> Void)? = nil
    ) -> TertitaryPositionCategoryViewController {
        let vc = Storyboard.positionCategory.instantiate(TertitaryPositionCategoryViewController.self)
        vc.dataSource.data = row.params.child?.map { PositionCategorySelectableRow(params: $0, primaryParams: row.primaryParams, secondaryParams: row.params) } ?? []
        vc.navigationItem.title = row.params.title
        vc.reactor = reactor
        vc.reactorUpdateHandler = reactorDidChange
        return vc
    }
    
    let dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [])
    
    var reactor = PositionCategoryReactor()
    
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
                            if data.params.child == nil {
                                CheckBoxProvider(checked: self.reactor.tertitaryRows.contains(data.params))
                                SpaceProvider(width: 6)
                            }
                            LabelProvider(identifier: "label", text: data.params.title, width: .fill)
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
                        
                        self.reactor.tertitaryRows = self.reactor.tertitaryRows.symmetricDifference([context.data.params])
                        self.dataSource.reloadData()
                        self.reactorUpdateHandler?(self.reactor)
                    }
                )
            ]
        )
    }
}
