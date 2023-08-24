//
//  Observerable+Property.swift
//  QuickDemoTemplate
//
//  Created by 鍾秉辰 on 2023/8/24.
//

import Foundation

@propertyWrapper
class Observable<Value> {
    
    private let observer: MutableObserver<Value>
    
    var projectedValue: ImmutableObservable<Value> { observer }
    
    init(wrappedValue: Value) {
        observer = MutableObserver(wrappedValue)
    }
    
    var wrappedValue: Value {
        get { observer.wrappedValue }
        set { observer.wrappedValue = newValue }
    }
}
