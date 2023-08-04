//
//  AppEnvironment.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/17.
//

import Foundation

struct AppEnvironment {
    
    private static var stacks: [Environment] = [Environment()]
    
    static var current: Environment {
        return stacks.last!
    }
    
    static func replaceCurrentEnvironment(
        safeAreaInsets: SafeAreaInsets = AppEnvironment.current.safeAreaInset
    ) {
        replaceCurrentEnvironment(env: Environment(safeAreaInset: safeAreaInsets))
    }
    
    static func replaceCurrentEnvironment(
        env: Environment
    ) {
        stacks.append(env)
        stacks.remove(at: stacks.count - 2)
    }
}
