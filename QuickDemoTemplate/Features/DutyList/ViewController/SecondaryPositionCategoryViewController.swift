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
        let dataSource = row.params.child?.map { PositionCategorySelectableRow(params: $0) } ?? []
        vc.navigationItem.title = row.params.title
        vc.reactor = PositionCategoryReactor(
            displayAll: reactor.displayAll,
            maxSelectableCount: reactor.maxSelectableCount,
            dataSource: dataSource,
            tertitaryRows: reactor.tertitaryRows
        )
        vc.reactorUpdateHandler = reactorDidChange
        return vc
    }
    
    let dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [])
    
    var reactor = PositionCategoryReactor(dataSource: []) {
        didSet {
            dataSource.data = reactor.dataSource
            reactor.alertNotifications = { [weak self] reactor in
                guard let self = self else { return }
                let alert = UIAlertController(title: "提示", message: "最多只能選\(reactor.maxSelectableCount)個哦!", defaultActionButtonTitle: "確定")
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
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
                        guard let self = self else { return }
                        view.contentView.isUserInteractionEnabled = false
                        view.contentView.provider = CompositionProvider(
                            layout: RowLayout("label", alignItems: .center).inset(8)
                        ) {
                            if data.params.child == nil {
                                CheckBoxProvider(checked: self.reactor.tertitaryRows.contains(data))
                                SpaceProvider(width: 6)
                                LabelProvider(identifier: "label", text: data.params.code % 100 == 0 ? data.params.title + "全部" : data.params.title, width: .fill)
                            } else {
                                LabelProvider(identifier: "label", text: data.params.title, width: .fill)
                                if let selectedCount = self.calculateSelectedCount(at: at) {
                                    SpaceProvider(width: 4)
                                    LabelProvider(text: "\(selectedCount)", color: .white, font: .systemFont(ofSize: 12))
                                        .background(UIColor(hexString: "FFA8A9"))
                                        .cornerRadius(8)
                                        .size(width: .absolute(16), height: .absolute(16))
                                        .alignment(.center)
                                        .padding(2)
                                        .adjustsFontSizeToFitWidth(true)
                                    SpaceProvider(width: 6)
                                }
                                ImageProvider(name: "icon_arrow_right_8")
                            }
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
                        if context.data.params.child == nil {
                            self.reactor.didSelectRow(at: context.index, with: context.data)
                            self.dataSource.reloadData()
                            return
                        }
                        
                        let vc = TertitaryPositionCategoryViewController.instantiate(with: context.data, reactor: self.reactor) { reactor in
                            self.reactor.tertitaryRows = reactor.tertitaryRows
                            self.dataSource.reloadData()
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
        
        let total = reactor.tertitaryRows.reduce(0, { $0 + ($1.isSubsetSubset(of: data) ? 1 : 0) })
        
        return total > 0 ? total : nil
    }
}

extension SecondaryPositionCategoryViewController:  UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            dataSource.data = reactor.dataSource
            return
        }
        
        let all = reactor.dataSource
            .compactMap(\.params.child)
            .flatMap { $0 }
            
        let result = all.filter { $0.title.contains(searchText) }.map { PositionCategorySelectableRow(params: $0) }
        dataSource.data = result
    }
}
