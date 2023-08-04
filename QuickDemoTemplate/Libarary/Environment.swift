//
//  Environment.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/17.
//

import Foundation

struct SafeAreaInsets {
    var top: CGFloat
    var left: CGFloat
    var right: CGFloat
    var bottom: CGFloat
    
    static var zero: SafeAreaInsets {
        return SafeAreaInsets(top: 0, left: 0, right: 0, bottom: 0)
    }
}

struct Environment {
    
    let safeAreaInset: SafeAreaInsets
    
    init(safeAreaInset: SafeAreaInsets = .zero) {
        self.safeAreaInset = safeAreaInset
    }
}
