//
//  Disposable.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/23.
//

import Foundation

extension Collection where Element == Disposable {
    func dispose() {
        forEach { $0.dispose() }
    }
}

final class Disposable {
    
    let dispose: () -> Void
    
    init(dispose: @escaping () -> Void) {
        self.dispose = dispose
    }
    
    deinit { dispose() }
    
    func add(to disposal: inout [Disposable]) {
        disposal.append(self)
    }
}
