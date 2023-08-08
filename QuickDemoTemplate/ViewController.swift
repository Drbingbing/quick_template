//
//  ViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/27.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var collectionView: CollectionView!
    
//    private let dataSource = ArrayDataSource<ViewControllerData>(data: []) { _, data in data.storyboard.rawValue }
    private var dataSource: [ViewControllerData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func bindingUI() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        dataSource = [
            ViewControllerData(storyboard: .chat),
            ViewControllerData(storyboard: .resume),
            ViewControllerData(storyboard: .positionCategory)
        ]
        
        collectionView.provider = CompositionProvider(
            layout: FlowLayout().inset(20)
        ) {
            LabelProvider(text: "Templates", color: .gray1, font: .qt_title, width: .fill)
            SpaceProvider(height: 12)
            SimpleViewProvider(
                layout: FlowLayout(spacing: 12),
                sizeSource: TemplateCardSizeSource(spacing: 12)
            ) {
                dataSource.map {
                    let view = TappableView<TemplateCardView>()
                    view.contentView.populate(data: $0)
                    return view
                }
            }
            .onTap { [weak self] context in
                guard let self = self else { return }
                let vc = self.dataSource[context.index].viewController
                context.view.push(vc)
            }
        }
    }
}

class TemplateCardSizeSource: SizeSource<UIView>, CollectionReloadable {
    
    private let spacing: CGFloat
    
    init(spacing: CGFloat = 0) {
        self.spacing = spacing
    }
    
    override func size(at index: Int, data: UIView, collectionSize: CGSize) -> CGSize {
            
        let width = (collectionSize.width - spacing) / 2
        let height = width * 1.33
        
        return CGSize(width: width, height: height)
    }
}

class TemplateCardView: BaseView {
    
    let collectionView = CollectionView()
    
    override func viewDidLoad() {
        addSubview(collectionView)
        
        collectionView.isUserInteractionEnabled = false
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.15
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = bounds
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        collectionView.sizeThatFits(size)
    }
    
    func populate(data: ViewControllerData) {
        collectionView.provider = CompositionProvider {
            LabelProvider(
                text: data.storyboard.rawValue,
                color: .gray1,
                font: .qt_body(size: 15).bolded
            )
            .padding(12, .horizontal)
            .padding(4, .vertical)
            SeparatorProvider()
            SpaceProvider(height: 4)
            data.preview
        }
    }
}


struct ViewControllerData {
    
    let storyboard: Storyboard
    
    init(storyboard: Storyboard) {
        self.storyboard = storyboard
    }
    
    var preview: Provider {
        switch storyboard {
        case .chat:
            return ChatPreviewProvider()
        case .resume:
            return ResumePreviewProvider()
        case .positionCategory:
            return ResumePreviewProvider()
        }
    }
    
    var viewController: UIViewController {
        switch storyboard {
        case .chat:
            return ChatViewController.instantiate()
        case .resume:
            return ResumeViewController.instantiate()
        case .positionCategory:
            return PrimaryPositionCategoryViewController.instantiate(with: DutyListDataGenerator.load(), displayAll: true, maxSelectableCount: 10)
        }
    }
}
    
