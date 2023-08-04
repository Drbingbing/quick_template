//
//  Nib.swift
//  Recruiter
//
//  Created by 鍾秉辰 on 2023/5/31.
//

import UIKit

enum Nib: String {
    case ActivityPageCell
    case ActivityMessageCell
    case SearchBarView
    case SearchBarCell
    case SearchSimpleCell
    case ManagementCell
}

protocol NibLoading {
    associatedtype CustomNibType
    
    static func from(nib: Nib) -> CustomNibType?
}

extension UICollectionView {
    
    func register(nib: Nib, inBundle bundle: Bundle = .main) {
        register(UINib(nibName: nib.rawValue, bundle: bundle), forCellWithReuseIdentifier: nib.rawValue)
    }
}

extension NibLoading {
    
    static func from(nib: Nib) -> Self? {
        guard let view = UINib(nibName: nib.rawValue, bundle: .main)
            .instantiate(withOwner: self, options: nil)
            .first as? Self else {
            assertionFailure("Nib not found")
            return nil
        }
        
        return view
    }
    
    func view(fromNib nib: Nib) -> UIView? {
        return UINib(nibName: nib.rawValue, bundle: .main).instantiate(withOwner: self, options: nil).first as? UIView
    }
}
