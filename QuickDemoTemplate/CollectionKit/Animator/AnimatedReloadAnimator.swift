//
//  AnimatedReloadAnimator.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/6/29.
//

import UIKit

public class AnimatedReloadAnimator: Animator {
    static let defaultEntryTransform: CATransform3D = CATransform3DTranslate(CATransform3DScale(CATransform3DIdentity, 0.8, 0.8, 1), 0, 0, -1)
    static let fancyEntryTransform: CATransform3D = {
        return .identity.scaleX(0.8).rotateX(0.5).translateX(-50).translateY(-100)
    }()
    
    public override func delete(collectionView: CollectionView, view: UIView) {
        if collectionView.isReloading, collectionView.bounds.intersects(view.frame) {
            
            UIView.animate(
                withDuration: 0.25,
                animations: {
                    view.layer.transform = .identity.scaleBy(0.8)
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
            view.layer.transform = .identity.scaleBy(0.8).translateY(-50)
            view.alpha = 0
            
            UIView.animate(
                withDuration: 0.5,
                delay: offsetTime,
                usingSpringWithDamping: 0.8,
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
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: [.layoutSubviews],
                animations: {
                    view.center = frame.center
                }, completion: nil
            )
            
        }
        
        if view.bounds.size != frame.bounds.size {
            
            UIView.animate(
                withDuration: 0.6,
                delay: 0,
                usingSpringWithDamping: 0.9,
                initialSpringVelocity: 0,
                options: [.layoutSubviews],
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
                options: [],
                animations: {
                    view.transform = .identity
                    view.alpha = 1
                },
                completion: nil
            )
            
        }
    }
}
