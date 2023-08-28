//
//  AnimatedReloadAnimator.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/29.
//

import UIKit

class AnimatedAnimator: Animator {
    var transform: CATransform3D
    var duration: TimeInterval
    var cascade: Bool

    init(
        transform: CATransform3D = CATransform3DIdentity,
        duration: TimeInterval = 0.5,
        cascade: Bool = false
    ) {
        self.transform = transform
        self.duration = duration
        self.cascade = cascade
        super.init()
    }

    
    public override func delete(collectionView: CollectionView, view: UIView) {
        if collectionView.isReloading, collectionView.bounds.intersects(view.frame) {
            
            UIView.animate(
                withDuration: duration,
                animations: {
                    view.layer.transform = self.transform
                    view.alpha = 0
                },
                completion: { _ in
                    if !collectionView.visibleCells.contains(view) {
                        view.recycleForCollectionKitReuse()
                        view.transform = CGAffineTransform.identity
                        view.alpha = 1
                    }
                }
            )
            
        } else {
            view.recycleForCollectionKitReuse()
        }
    }
    
    public override func insert(collectionView: CollectionView, view: UIView, at: Int, frame: CGRect) {
        view.bounds = frame.bounds
        view.center = frame.center
        
        if collectionView.isReloading, collectionView.hasReloaded, collectionView.bounds.intersects(frame) {
            
            let offsetTime: TimeInterval = TimeInterval(frame.origin.distance(collectionView.contentOffset) / 3000)
            UIView.performWithoutAnimation {
                view.layer.transform = transform
                view.alpha = 0
            }
            
            UIView.animate(
                withDuration: duration,
                delay: offsetTime,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: [],
                animations: {
                    view.transform = .identity
                    view.alpha = 1
                }
            )
            
        }
    }
    
    public override func update(collectionView: CollectionView, view: UIView, at: Int, frame: CGRect) {
        if view.center != frame.center {
            
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: [.allowUserInteraction],
                animations: {
                    view.center = frame.center
                }, completion: nil
            )
            
        }
        
        if view.bounds.size != frame.bounds.size {
            
            UIView.animate(
                withDuration: duration,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: [.allowUserInteraction, .layoutSubviews],
                animations: {
                    view.bounds.size = frame.bounds.size
                },
                completion: nil
            )
        }
        
        if view.alpha != 1 || view.transform != .identity {
            
            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: [.allowUserInteraction],
                animations: {
                    view.transform = .identity
                    view.alpha = 1
                },
                completion: nil
            )
            
        }
    }
}

