//
//  SecondaryPositionCategoryViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import SwifterSwift
import UIKit

class SecondaryPositionCategoryViewController: UIViewController {
    
    static func instantiate(
        with row: PositionCategorySelectableRow,
        reactor: PositionCategoryReactor,
        reactorDidChange: ((PositionCategoryReactor) -> Void)? = nil
    ) -> SecondaryPositionCategoryViewController {
        let vc = Storyboard.positionCategory.instantiate(SecondaryPositionCategoryViewController.self)
        vc.dataSource.data = row.params.child?.map { PositionCategorySelectableRow(params: $0) } ?? []
        vc.navigationItem.title = row.params.title
        vc.reactor = reactor
        vc.reactorUpdateHandler = reactorDidChange
        return vc
    }
    
    var dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [])
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
                    viewSource: { [weak self] (view: TappableView<CollectionView>, data: PositionCategorySelectableRow, at: Int) in
                        guard let self = self else { return }
                        view.contentView.isUserInteractionEnabled = false
                        view.contentView.provider = CompositionProvider(
                            layout: RowLayout("label", alignItems: .center).inset(8)
                        ) {
                            LabelProvider(identifier: "label", text: data.params.title, width: .fill)
                            if let selectedCount = self.calculateSelectedCount(at: at) {
                                SpaceProvider(width: 4)
                                LabelProvider(text: "\(selectedCount)", color: .white, font: .systemFont(ofSize: 12))
                                    .background(UIColor(hexString: "FFA8A9"))
                                    .cornerRadius(8)
                                    .size(width: .absolute(16), height: .absolute(16))
                                    .alignment(.center)
                                    .padding(2)
                                SpaceProvider(width: 6)
                            }
                            ImageProvider(name: "icon_arrow_right_8")
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
                        let vc = TertitaryPositionCategoryViewController.instantiate(with: context.data, reactor: self.reactor) { reactor in
                            self.reactor = reactor
                            self.reactorUpdateHandler?(self.reactor)
                        }
                        context.view.push(vc)
                    }
                )
            ]
        )
    }
    
    private func calculateSelectedCount(at atIndex: Int) -> Int? {
        let data = dataSource.data(at: atIndex)
        
        let total = reactor.tertitaryRows.reduce(0, { $0 + ($1.isSubset(of: data) ? 1 : 0) })
        
        return total > 0 ? total : nil
    }
}
