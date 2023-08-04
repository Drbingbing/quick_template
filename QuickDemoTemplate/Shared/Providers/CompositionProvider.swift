//
//  CompositionProvider.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/7/27.
//

import Foundation
import UIKit

@resultBuilder
public struct ProviderArrayBuilder {
    
    public static func buildExpression(_ expression: Provider) -> [Provider] {
        [expression]
    }
    public static func buildExpression(_ expression: [Provider]) -> [Provider] {
        expression
    }
    public static func buildBlock(_ segments: [Provider]...) -> [Provider] {
        segments.flatMap { $0 }
    }
    public static func buildIf(_ segments: [Provider]?...) -> [Provider] {
        segments.flatMap { $0 ?? [] }
    }
    public static func buildEither(first: [Provider]) -> [Provider] {
        first
    }
    public static func buildEither(second: [Provider]) -> [Provider] {
        second
    }
    public static func buildArray(_ components: [[Provider]]) -> [Provider] {
        components.flatMap { $0 }
    }
    public static func buildLimitedAvailability(_ component: [Provider]) -> [Provider] {
        component
    }
}

class CompositionProvider: ComposedProvider {
    
    init(
        identifier: String? = nil,
        layout: Layout = FlowLayout(),
        animator: Animator? = nil,
        @ProviderArrayBuilder _ sections: () -> [Provider]
    ) {
        super.init(
            identifier: identifier,
            layout: layout,
            animator: animator,
            sections: sections()
        )
    }
    
    @discardableResult
    func background(_ color: UIColor) -> GroupedProvider {
        return GroupedProvider { self }
    }
}

