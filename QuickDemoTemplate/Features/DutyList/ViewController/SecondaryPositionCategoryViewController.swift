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
        vc.dataSource.data = row.params.child?.map { PositionCategorySelectableRow(params: $0, primaryParams: row.params) } ?? []
        vc.navigationItem.title = row.params.title
        vc.reactor = reactor
        vc.reactorUpdateHandler = reactorDidChange
        return vc
    }
    
    var dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [])
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
                    viewSource: { [weak self] (view: TappableView<CollectionView>, data: PositionCategorySelectableRow, at: Int) in
                        guard let self = self else { return }
                        view.contentView.isUserInteractionEnabled = false
                        view.contentView.provider = CompositionProvider(
                            layout: RowLayout("label", alignItems: .center).inset(8)
                        ) {
                            LabelProvider(identifier: "label", text: data.params.title, width: .fill)
                            if self.reactor.secondaryRows.contains(data.params) {
                                SpaceProvider(width: 4)
                                LabelProvider(text: "\(self.calculateSelectedCount(at: at))", color: .white, font: .systemFont(ofSize: 12))
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
                            self.reactor.tertitaryRows = reactor.tertitaryRows
                            if reactor.tertitaryRows.isEmpty {
                                self.reactor.secondaryRows.remove(context.data.params)
                            } else {
                                self.reactor.secondaryRows.insert(context.data.params)
                            }
                            self.reactorUpdateHandler?(self.reactor)
                            self.dataSource.reloadData()
                        }
                        let root = UINavigationController(rootViewController: vc)
                        context.view.present(root)
                    }
                )
            ]
        )
    }
    
    private func calculateSelectedCount(at atIndex: Int) -> Int {
        let data = dataSource.data(at: atIndex)
        if let child = data.params.child {
            return reactor.tertitaryRows.filter { child.contains($0) }.count
        }
        
        return 0
    }
}
