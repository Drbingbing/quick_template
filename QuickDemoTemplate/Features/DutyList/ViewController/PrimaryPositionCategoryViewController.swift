//
//  DutyListViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/26.
//

import SwiftyJSON
import SwifterSwift
import UIKit

class PrimaryPositionCategoryViewController: UIViewController {
    
    static func instantiate(with rows: [PositionCategorySelectableRow], displayAll: Bool = false) -> PrimaryPositionCategoryViewController {
        let vc = Storyboard.positionCategory.instantiate(PrimaryPositionCategoryViewController.self)
        vc.reactor = PositionCategoryReactor(displayAll: displayAll, tertitaryRows: [])
        vc.dataSource.data = rows
        return vc
    }
    
    let dataSource = ArrayDataSource<PositionCategorySelectableRow>(data: [], identifierMapper: { $1.params.title })
    
    var reactor = PositionCategoryReactor() {
        didSet { dataSource.reloadData() }
    }
    
    @IBOutlet weak var collectionView: CollectionView!
    
    private var isExpand: Bool = false {
        didSet { collectionView.setNeedsReload() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func bindingUI() {
        navigationItem.title = "職務類別"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        collectionView.provider = ComposedHeaderProvider(
            headerViewSource: { [weak self] (view: PositionCategoryViewHeader, data: HeaderData, at: Int) in
                guard let self else { return }
                view.populate(data: [], isExpand: self.isExpand)
            },
            headerSizeSource: { [weak self] _, _, size in
                guard let self else { return .zero }
                return PositionCategoryViewHeader.sizeFor(
                    data: [],
                    isExpand: self.isExpand,
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
                                    .adjustsFontSizeToFitWidth(true)
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
                    tapHandler: { context in
                        let vc = SecondaryPositionCategoryViewController.instantiate(with: context.data, reactor: self.reactor) { reactor in
                            self.reactor = reactor
                        }
                        context.view.push(vc)
                    }
                )
            ]
        )
        
    }
    
    private func calculateSelectedCount(at atIndex: Int) -> Int? {
        let data = dataSource.data(at: atIndex)
        
        var total = 0
        for tertitaryRow in reactor.tertitaryRows {
            if tertitaryRow.code - data.params.code < 1000, tertitaryRow.code - data.params.code > 0 {
                total += 1
            }
        }
        return total > 0 ? total : nil
    }
}
