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
        vc.reactor = PositionCategoryReactor(
            displayAll: reactor.displayAll,
            maxSelectableCount: reactor.maxSelectableCount,
            dataSource: data,
            tertitaryRows: reactor.tertitaryRows
        )
        vc.navigationItem.title = row.params.title
        vc.reactorUpdateHandler = reactorDidChange
        return vc
    }
    
    let dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [])
    
    var reactor = PositionCategoryReactor(dataSource: []) {
        didSet {
            dataSource.data = reactor.dataSource
            reactor.alertNotifications = { [weak self] reactor in
                guard let self = self else { return }
                let alert = UIAlertController(title: "提示", message: "最多只能選\(reactor.maxSelectableCount)個喔!", defaultActionButtonTitle: "確定")
                self.present(alert, animated: true)
            }
        }
    }
    
    private var isExpand: Bool = false {
        didSet { dataSource.reloadData() }
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
            headerViewSource: { [weak self] (view: PositionCategoryViewHeader, data: HeaderData, at: Int) in
                guard let self else { return }
                view.maxSelectableCount = self.reactor.maxSelectableCount
                view.searchBar.delegate = self
                view.populate(
                    data: self.reactor.tertitaryRows,
                    isExpand: self.isExpand,
                    onExpand: { self.isExpand.toggle() },
                    onDelete: { row in
                        self.reactor.tertitaryRows.remove(row)
                        self.dataSource.reloadData()
                        self.reactorUpdateHandler?(self.reactor)
                    }
                )
            },
            headerSizeSource: { [weak self] _, _, size in
                guard let self = self else { return .zero }
                return PositionCategoryViewHeader.sizeFor(
                    data: self.reactor.tertitaryRows,
                    isExpand: self.isExpand,
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
                        
                        self.reactor.didSelectRow(at: context.index, with: context.data)
                        self.dataSource.data = reactor.dataSource
                        self.reactorUpdateHandler?(self.reactor)
                    }
                )
            ]
        )
    }
}

extension TertitaryPositionCategoryViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataSource.data = reactor.dataSource
            return
        }
        
        let all = reactor.dataSource.map(\.params)
            
        let result = all.filter { $0.title.contains(searchText) }.map { PositionCategorySelectableRow(params: $0) }
        dataSource.data = result
    }
}
