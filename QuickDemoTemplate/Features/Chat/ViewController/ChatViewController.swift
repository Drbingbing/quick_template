//
//  ChatViewController.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/28.
//

import SnapKit
import UIKit
import RxSwift
import RxCocoa

final class ChatViewController: UIViewController {
    
    @IBOutlet weak var collectionView: CollectionView!
    
    private let dataSource = MessageDataSource(currentSender: SampleData.bingbing)
    
    private let disposeBag = DisposeBag()
    
    var currentSender: MockUser {
        return SampleData.steven
    }
    
    static func instantiate() -> ChatViewController {
        return Storyboard.chat.instantiate(ChatViewController.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func bindingUI() {
        
        navigationItem.title = "Chat"
        navigationItem.largeTitleDisplayMode = .never
        
        dataSource.data = SampleData.getMessages(count: 60)
        
        collectionView.delaysContentTouches = false
        collectionView.provider = BasicProvider(
            dataSource: dataSource,
            viewSource: MessageViewSource(),
            sizeSource: MessageSizeSource(delegate: self),
            layout: MessageLayout(),
            animator: AnimatedReloadAnimator()
        )
        collectionView.reloadData()
        collectionView.scrollToBottom(animated: false)
    }
}

extension ChatViewController: MessageSizeSourceDelegate {
    
    func isFromCurrentSender(for message: MessageType) -> Bool {
        return message.sender.senderId == currentSender.senderId
    }
}

extension UIScrollView {
    
    func scrollToBottom(animated: Bool) {
        var target = CGPoint(x: contentOffset.x, y: offsetFrame.maxY)
        
        target.y += AppEnvironment.current.safeAreaInset.bottom 
        
        setContentOffset(target, animated: animated)
    }
}
