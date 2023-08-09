//
//  BottomSheetContentViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/8.
//

import UIKit
import SnapKit

class BottomSheetContentViewController: UIViewController {
    
    private let collectionView = CollectionView()
    private let visualEffetView = UIVisualEffectView(effect: UIBlurEffect(style: .prominent))
    private let lineView = UIView()
    
    var provider: Provider? {
        didSet { collectionView.provider = provider }
    }
    
    override func bindingUI() {
        view.addSubview(visualEffetView)
        view.addSubview(lineView)
        visualEffetView.contentView.addSubview(collectionView)
        
        lineView.backgroundColor = .systemGray5
    }
    
    override func updateViewConstraints() {
        visualEffetView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.top.equalTo(view.snp.top)
            make.height.equalTo(0.5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(visualEffetView.contentView.snp.top)
            make.leading.equalTo(visualEffetView.contentView.snp.leading)
            make.trailing.equalTo(visualEffetView.contentView.snp.trailing)
            make.bottom.equalTo(visualEffetView.contentView.snp.bottom).inset(AppEnvironment.current.safeAreaInset.bottom)
        }
        
        super.updateViewConstraints()
    }
}
