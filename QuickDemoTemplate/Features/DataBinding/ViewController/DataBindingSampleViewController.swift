//
//  DataBindingSampleViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/24.
//

import UIKit

protocol DataBindingSampleViewModelProtocol {
    var inputs: DataBindingSampleViewModelInput { get }
    var outputs: DataBindingSampleViewModelOutputs { get }
}

protocol DataBindingSampleViewModelInput {
    func viewDidLoad()
    func didTapLetter(at atIndex: Int)
    func didBarButtonTapped()
}

protocol DataBindingSampleViewModelOutputs {
    var samples: ImmutableObservable<[String]> { get }
}

final class DataBindingViewModel: DataBindingSampleViewModelProtocol, DataBindingSampleViewModelInput, DataBindingSampleViewModelOutputs {
    
    var inputs: DataBindingSampleViewModelInput { return self }
    var outputs: DataBindingSampleViewModelOutputs { return self }
    
    var samples: ImmutableObservable<[String]> { $sampleVariable }
    @Observable var sampleVariable: [String] = []
    
    func viewDidLoad() {
        sampleVariable = makeLetters()
    }
    
    func didTapLetter(at atIndex: Int) {
        sampleVariable.remove(at: atIndex)
    }
    
    func didBarButtonTapped() {
        sampleVariable = makeLetters()
    }
    
    private func makeLetters() -> [String] {
        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value

        return (0..<26).map { Character(UnicodeScalar(aCode + $0)!) }.map(\.string)
    }
}

final class DataBindingSampleViewController: UIViewController {
    
    static func instantiate() -> DataBindingSampleViewController {
        return Storyboard.dataBinding.instantiate(DataBindingSampleViewController.self)
    }
    
    @IBOutlet weak var collectionView: CollectionView!
    
    var viewModel: DataBindingSampleViewModelProtocol = DataBindingViewModel()
    var disposeBag: [Disposable] = []
    
    private var dataSource = [String]() {
        didSet { collectionView.provider = provider }
    }
    
    private var provider: Provider {
        CompositionProvider(
            layout: FlowLayout(spacing: 8).inset(20),
            animator: AnimatedReloadAnimator(duration: 0.25)
        ) {
            for (index, data) in dataSource.enumerated() {
                LabelProvider(text: data)
                    .size(width: .absolute(32), height: .absolute(32))
                    .padding(UIEdgeInsets(8))
                    .background(.white)
                    .textAlignment(.center)
                    .cornerRadius(4)
                    .shadow(4)
                    .onTap { [weak self] context in
                        self?.viewModel.inputs.didTapLetter(at: index)
                    }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func bindingUI() {
        view.backgroundColor = .rt_gray6
        
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "DataBinding Sample"
        
        navigationItem.setRightBarButton(
            UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.left.circle"), style: .plain, target: self, action: #selector(didBarButtonTapped)),
            animated: false
        )
        
        collectionView.provider = provider
        
        viewModel.inputs.viewDidLoad()
    }
    
    override func bindingViewModel() {
        viewModel.outputs.samples
            .sink { [weak self] newValue in
                self?.dataSource = newValue
            }
            .add(to: &disposeBag)
    }
    
    @objc private func didBarButtonTapped() {
        viewModel.inputs.didBarButtonTapped()
    }
}
